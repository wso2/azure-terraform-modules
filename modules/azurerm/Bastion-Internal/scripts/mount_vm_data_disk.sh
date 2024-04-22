#!/bin/bash

# -------------------------------------------------------------------------------------
#
# Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

set -e

tmpDirPath="/tmp/home"
disk_lun=disk_lun_value
partitionMountPath="/home"
partitionWaitTimeInSeconds=3

# Logging function
function log_info() {
    local string=$*
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')][INFO]: ${string}" >&1
}

log_info "Disk LUN: ${disk_lun}"
log_info "Partition mount path: ${partitionMountPath}"

diskPath="/dev/$(lsblk -o NAME,HCTL -l | grep -E -i "([a-z])*(\s+)([0-9]*):([0-9]*):([0-9]*):${disk_lun}" | awk '{print $1}')"
partition="${diskPath}1"

log_info "Disk path: ${diskPath}"
log_info "Partition: ${partition}"

if ! sudo mount | grep "${partition}" | grep -q "${partitionMountPath}"
then
  log_info "${partition} is not mounted at ${partitionMountPath}"
  if ! sudo lsblk -lp | grep "${partition}" | grep -q "part"
  then
    log_info "${diskPath} is not formatted and partitioned"
    sudo parted "${diskPath}" --script mklabel gpt mkpart xfspart xfs 0% 100%
    sudo mkfs.xfs "${partition}"
    sleep ${partitionWaitTimeInSeconds}
    sudo partprobe "${partition}"
    log_info "${diskPath} is partitioned and formatted with xfs type"

    log_info "Clear temp directory ${tmpDirPath}"
    rm -rf "${tmpDirPath}"   
    log_info "Copy ${partitionMountPath}/* to ${tmpDirPath}/"
    mkdir "${tmpDirPath}"
    cp -rp ${partitionMountPath}/* "${tmpDirPath}/"
    sudo rm -rf ${partitionMountPath}/*  
 
    log_info "Mounting ${partition} to ${partitionMountPath}"
    sudo mount "${partition}" "${partitionMountPath}"

    log_info "Copy ${tmpDirPath}/* to ${partitionMountPath}/"
    cp -rp "${tmpDirPath}"/* ${partitionMountPath}
    rm -rf "${tmpDirPath}"
  fi

  if ! test -d ${partitionMountPath}
  then
    log_info "Creating directory ${partitionMountPath}"
    sudo mkdir ${partitionMountPath}
  fi

  UUID=$(lsblk -lp -o NAME,UUID | grep "${partition}" | awk '{print $2}')
  if ! < /etc/fstab grep "${UUID}" | grep -q ${partitionMountPath} 
  then 

    # Add the UUID to /etc/fstab so that the drive is mounted automatically after reboot.
    # We use the UUID instead of the device name (ex: /dev/sdc1) because the UUID avoids the incorrect
    # disk from being mounted if the OS detects a disk error during boot.
    echo "UUID=${UUID}    ${partitionMountPath}    xfs    defaults,nofail    1    2" | sudo tee --append /etc/fstab
    log_info "/etc/fstab is updated with partition: ${partition}, UUID: ${UUID}"
  fi

  log_info "Refresh all mount points"
  sudo mount -a
  log_info "${partition} is successfully mounted at ${partitionMountPath}"
else
  log_info "${partition} is mounted at ${partitionMountPath}"
fi
