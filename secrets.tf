#----------------------------------------------------------
# Enable secrets engines
#----------------------------------------------------------
# Enable kv-v2 secrets engine in the finance namespace
resource "vault_mount" "kv-v2" {
  namespace = vault_namespace.training.path_fq
  path = "kv-v2"
  type = "kv-v2"
}
