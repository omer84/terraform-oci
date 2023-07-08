# Home Region Subscription DataSource
data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# ADs DataSource
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# Images DataSource
data "oci_core_images" "OSImage" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.Shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Bastion Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenBastionServer_VNIC1_attach" {
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenBastionServer.id
}

# Bastion Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenBastionServer_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenBastionServer_VNIC1_attach.vnic_attachments.0.vnic_id
}

# WebServer1 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver1_VNIC1_attach" {
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver1.id
}

# WebServer1 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver1_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenWebserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

# WebServer2 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver2_VNIC1_attach" {
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver2.id
}

# WebServer2 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver2_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenWebserver2_VNIC1_attach.vnic_attachments.0.vnic_id
}

# DBNodes DataSource
data "oci_database_db_nodes" "DBNodeList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  db_system_id   = oci_database_db_system.FoggyKitchenDBSystem.id
}

# DBNodes Details DataSource
data "oci_database_db_node" "DBNodeDetails" {
  db_node_id = lookup(data.oci_database_db_nodes.DBNodeList.db_nodes[0], "id")
}

# DBNodes Details VNIC DataSource
data "oci_core_vnic" "FoggyKitchenDBSystem_VNIC1" {
  vnic_id = data.oci_database_db_node.DBNodeDetails.vnic_id
}

# BackendServer1 Compute VNIC DataSource
data "oci_core_vnic_attachments" "FoggyKitchenBackendserver1_VNIC1_attach" {
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.ExternalCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenBackendserver1.id
}

# BackendServer1 Compute VNIC Attachment DataSource
data "oci_core_vnic" "FoggyKitchenBackendserver1_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenBackendserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}
