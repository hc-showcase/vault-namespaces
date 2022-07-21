#------------------------------------------------------------------------------
# To leverage more than one namespace, define a vault provider per namespace
#------------------------------------------------------------------------------

provider "vault" {}

#---------------------------------------------------------------
# Create namespaces
#   education has childnamespace, 'training'
#       training has childnamespace, 'beta-training'
#   education has childnamespace, 'certification'
#---------------------------------------------------------------
# vault namespace create education
resource "vault_namespace" "education" {
  path = "education"
}

# Create a childnamespace, 'training' under 'education'
# vault namespace create -namespace=education training
resource "vault_namespace" "training" {
  namespace = vault_namespace.education.path
  path      = "training"
}

# Create a childnamespace, 'certification' under 'education'
# vault namespace create -namespace=education certification
resource "vault_namespace" "certification" {
  namespace = vault_namespace.education.path
  path      = "certification"
}

# Create a childnamespace, 'beta-training' under 'training'
# vault namespace create -namespace=education/training beta-training
resource "vault_namespace" "beta-training" {
  namespace = vault_namespace.training.path_fq
  path      = "beta-training"
}
