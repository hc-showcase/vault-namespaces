#--------------------------------
# Enable userpass auth method in education namespace
#--------------------------------
# vault auth enable -namespace=education userpass
resource "vault_auth_backend" "userpass" {
  namespace = vault_namespace.education.path
  type      = "userpass"
}

# Create a user named, "bob"
resource "vault_generic_endpoint" "bob" {
  namespace            = vault_namespace.education.path
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/bob"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "password": "training"
}
EOT
}

resource "vault_identity_entity" "bob" {
  namespace = vault_namespace.education.path
  name      = "Bob TheEducationAdmin"
  policies  = ["education-admin"]
}

resource "vault_identity_entity_alias" "bob" {
  namespace      = vault_namespace.education.path
  name           = "bob"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.bob.id
}

resource "vault_identity_group" "internal" {
  namespace         = vault_namespace.training.path_fq
  name              = "Training Admin"
  type              = "internal"
  policies          = ["training-admin"]
  member_entity_ids = [vault_identity_entity.bob.id]
}
