resource "hcp_vault_cluster" "vault" {
  count             = var.hcp_vault_name != "" ? 1 : 0
  cluster_id        = var.hcp_vault_name
  hvn_id            = hcp_hvn.hvn.hvn_id
  public_endpoint   = var.hcp_vault_public_endpoint
  min_vault_version = var.hcp_vault_version
  tier              = var.hcp_vault_tier

  dynamic "metrics_config" {
    for_each = local.datadog_config
    content {
      datadog_api_key = metrics_config.value.api_key
      datadog_region  = metrics_config.value.region
    }
  }

  dynamic "audit_log_config" {
    for_each = local.datadog_config
    content {
      datadog_api_key = audit_log_config.value.api_key
      datadog_region  = audit_log_config.value.region
    }
  }
}