# IAM Requestor Group
resource "oci_identity_group" "FoggyKitchenRequestorGroup" {
  provider       = oci.homeregion
  name           = "FoggyKitchenRequestorGroup"
  description    = "FoggyKitchenRequestorGroup"
  compartment_id = var.tenancy_ocid
}

# IAM Requestor Policy
resource "oci_identity_policy" "FoggyKitchenRequestorPolicy" {
  provider       = oci.homeregion
  name           = "FoggyKitchenRequestorPolicy"
  description    = "FoggyKitchenRequestorPolicy"
  compartment_id = var.tenancy_ocid

  statements = ["Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage virtual-network-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}",
    "Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage instance-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}",
    "Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage remote-peering-from in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}",
  ]
}

# IAM Acceptor Group
resource "oci_identity_group" "FoggyKitchenAcceptorGroup" {
  provider       = oci.homeregion
  name           = "FoggyKitchenAcceptorGroup"
  description    = "FoggyKitchenAcceptorGroup"
  compartment_id = var.tenancy_ocid
}

# IAM Acceptor Policy
resource "oci_identity_policy" "FoggyKitchenAcceptorPolicy" {
  provider       = oci.homeregion
  name           = "FoggyKitchenAcceptorPolicy"
  description    = "FoggyKitchenAcceptorPolicy"
  compartment_id = var.tenancy_ocid

  statements = ["Allow group ${oci_identity_group.FoggyKitchenAcceptorGroup.name} to manage remote-peering-to in compartment id ${oci_identity_compartment.ExternalCompartment.id}",
    "Allow group ${oci_identity_group.FoggyKitchenAcceptorGroup.name} to manage virtual-network-family in compartment id ${oci_identity_compartment.ExternalCompartment.id}",
    "Allow group ${oci_identity_group.FoggyKitchenAcceptorGroup.name} to manage instance-family in compartment id ${oci_identity_compartment.ExternalCompartment.id}",
  ]
}
