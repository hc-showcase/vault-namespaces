#----------------------------------------------------------
# Enable secrets engines
#----------------------------------------------------------
resource "vault_mount" "kv-v2" {
  namespace = vault_namespace.training.path_fq
  path = "kv"
  type = "kv-v2"
}
