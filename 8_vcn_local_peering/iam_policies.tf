# IAM Policy to allow Admin group to manage LPGs in FoggyKitchen compartment
resource "oci_identity_policy" "FoggyKitchenLPGPolicy1" {
  provider       = oci.homeregion
  depends_on     = [oci_identity_compartment.FoggyKitchenCompartment, oci_identity_compartment.ExternalCompartment]
  name           = "FoggyKitchenLPGPolicy"
  description    = "FoggyKitchenLocalPeeringPolicy1"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to manage local-peering-from in compartment ${oci_identity_compartment.FoggyKitchenCompartment.name}"
  ]
}

# IAM Policy to allow Admin group to manage LPGs in External compartment
resource "oci_identity_policy" "FoggyKitchenLPGPolicy2" {
  provider       = oci.homeregion
  depends_on     = [oci_identity_compartment.FoggyKitchenCompartment, oci_identity_compartment.ExternalCompartment]
  name           = "FoggyKitchenLPGPolicy"
  description    = "FoggyKitchen LocalPeeringPolicy2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  statements = [
    "Allow group Administrators to manage local-peering-to in compartment ${oci_identity_compartment.ExternalCompartment.name}",
    "Allow group Administrators to inspect vcns in compartment ${oci_identity_compartment.ExternalCompartment.name}",
    "Allow group Administrators to inspect local-peering-gateways in compartment ${oci_identity_compartment.ExternalCompartment.name}"
  ]
}
