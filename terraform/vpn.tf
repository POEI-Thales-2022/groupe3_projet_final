resource "azurerm_public_ip" "vpn_ip" {
    name                = "vpn-ip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Dynamic"
    
    domain_name_label   = "finalGroupe3"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = tls_private_key.key.algorithm
  private_key_pem = tls_private_key.key.private_key_pem

  # Certificate expires after 1 year
  validity_period_hours = 8766 

  # Generate a new certificate if Terraform is run within three
  # hours of the certificate's expiration time.
  early_renewal_hours = 200

  # Allow to be used as a CA
  is_ca_certificate = true

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth",
    "cert_signing"
  ]

  dns_names = [ azurerm_public_ip.vpn_ip.domain_name_label ]

  subject {
      common_name  = "CAOpenVPN"
      organization = "dev env"
  }
}

resource "local_file" "ca_pem" {
  filename = "caCert.pem"
  content  = tls_self_signed_cert.ca.cert_pem
}

resource "null_resource" "cert_encode" {
  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    command = "openssl x509 -in caCert.pem -outform der | base64 -w0 > caCert.der"
  }

  depends_on =  [ local_file.ca_pem ]
}

data "local_file" "ca_der" {
  filename = "caCert.der"

  depends_on = [
    null_resource.cert_encode
  ]
}

resource "tls_private_key" "client_cert" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "tls_cert_request" "client_cert" {
  key_algorithm = tls_private_key.client_cert.algorithm
  private_key_pem = tls_private_key.client_cert.private_key_pem

  # dns_names = [ azurerm_public_ip.vpn_ip.domain_name_label ]

  subject {
      common_name  = "ClientOpenVPN"
      organization = "dev env"
  }
}

resource "tls_locally_signed_cert" "client_cert" {
  cert_request_pem = tls_cert_request.client_cert.cert_request_pem

  ca_key_algorithm = tls_private_key.key.algorithm
  ca_private_key_pem = tls_private_key.key.private_key_pem
  ca_cert_pem = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 43800

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "key_encipherment",
    "client_auth",
  ]
}

resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "vpn-gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    type     = "Vpn"
    vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
        name                          = "vpn-gateway"
    public_ip_address_id          = azurerm_public_ip.vpn_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
  }

  vpn_client_configuration {
    address_space = ["10.1.0.0/16"]

    vpn_client_protocols = ["OpenVPN"]
        root_certificate {
            name = "terraformselfsignedder"

            public_cert_data = data.local_file.ca_der.content
        }
  }
}

output "client_cert" {
  value = tls_locally_signed_cert.client_cert.cert_pem
}


output "client_key" {
  value = tls_private_key.client_cert.private_key_pem
}

output "vpn_id" {
  value = azurerm_virtual_network_gateway.vpn-gateway.id
}