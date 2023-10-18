# -------------------------------------------------------------------------------------
#
# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "azurerm_kubernetes_cluster_node_pool" "kubernetes_cluster_node_pool" {
    lifecycle {
        ignore_changes = [
          node_count,
          orchestrator_version,
        ]
    }

    name                          = join("", ["aksnp", var.node_pool_name])
    node_count                    = var.node_pool_count
    vm_size                       = var.node_pool_vm_size
    zones                         = var.node_pool_availability_zones
    os_disk_size_gb               = var.node_pool_os_disk_size_gb
    os_disk_type                  = var.node_pool_os_disk_type
    enable_auto_scaling           = var.node_pool_enable_auto_scaling
    vnet_subnet_id                = var.aks_subnet_id
    kubernetes_cluster_id         = var.aks_cluster_id
    max_count                     = var.node_pool_max_count
    min_count                     = var.node_pool_min_count
    max_pods                      = var.node_pool_max_pods
    orchestrator_version          = var.node_pool_orchestrator_version
    enable_node_public_ip         = false
    mode                          = var.node_pool_mode
    os_type                       = var.node_pool_os_type

    tags = var.default_tags

}
