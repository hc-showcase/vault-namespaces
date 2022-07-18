# Create admin policy in the education namespace
# vault policy write -namespace=education education-admin education-admin.hcl
resource "vault_policy" "admin_policy_education" {
  namespace = vault_namespace.education.path
  name      = "education-admin"
  policy    = file("policies/education-admin.hcl")
}

# Create admin policy in the 'education/training' namespace
# vault policy write -namespace=education/training training-admin training-admin.hcl
resource "vault_policy" "admin_policy_training" {
  namespace = vault_namespace.training.path_fq
  name      = "training-admin"
  policy    = file("policies/training-admin.hcl")
}
