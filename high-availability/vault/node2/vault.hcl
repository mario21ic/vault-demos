# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

# Full configuration options can be found at https://www.consul.io/docs/agent/config

# datacenter
# This flag controls the datacenter in which the agent is running. If not provided,
# it defaults to "dc1". Consul has first-class support for multiple datacenters, but 
# it relies on proper configuration. Nodes in the same datacenter should be on a 
# single LAN.
datacenter = "dc1"
node_name = "consul_c2"

# data_dir
# This flag provides a data directory for the agent to store state. This is required
# for all agents. The directory should be durable across reboots. This is especially
# critical for agents that are running in server mode as they must be able to persist
# cluster state. Additionally, the directory must support the use of filesystem
# locking, meaning some types of mounted folders (e.g. VirtualBox shared folders) may
# not be suitable.
data_dir = "/opt/consul"

# client_addr
# The address to which Consul will bind client interfaces, including the HTTP and DNS
# servers. By default, this is "127.0.0.1", allowing only loopback connections. In
# Consul 1.0 and later this can be set to a space-separated list of addresses to bind
# to, or a go-sockaddr template that can potentially resolve to multiple addresses.
#client_addr = "0.0.0.0"
client_addr = "127.0.0.1"

# ui
# Enables the built-in web UI server and the required HTTP routes. This eliminates
# the need to maintain the Consul web UI files separately from the binary.
# Version 1.10 deprecated ui=true in favor of ui_config.enabled=true
#ui_config{
#  enabled = true
#}

# server
# This flag is used to control if an agent is in server or client mode. When provided,
# an agent will act as a Consul server. Each Consul cluster must have at least one
# server and ideally no more than 5 per datacenter. All servers participate in the Raft
# consensus algorithm to ensure that transactions occur in a consistent, linearizable
# manner. Transactions modify cluster state, which is maintained on all server nodes to
# ensure availability in the case of node failure. Server nodes also participate in a
# WAN gossip pool with server nodes in other datacenters. Servers act as gateways to
# other datacenters and forward traffic as appropriate.
#server = true
server = false

# Bind addr
# You may use IPv4 or IPv6 but if you have multiple interfaces you must be explicit.
#bind_addr = "[::]" # Listen on all IPv6
#bind_addr = "0.0.0.0" # Listen on all IPv4
bind_addr = "192.168.10.117"

#
# Advertise addr - if you want to point clients to a different address than bind or LB.
#advertise_addr = "127.0.0.1"

# Enterprise License
# As of 1.10, Enterprise requires a license_path and does not have a short trial.
#license_path = "/etc/consul.d/consul.hclic"

# bootstrap_expect
# This flag provides the number of expected servers in the datacenter. Either this value
# should not be provided or the value must agree with other servers in the cluster. When
# provided, Consul waits until the specified number of servers are available and then
# bootstraps the cluster. This allows an initial leader to be elected automatically.
# This cannot be used in conjunction with the legacy -bootstrap flag. This flag requires
# -server mode.
#bootstrap_expect=3

# encrypt
root@vault-node2:~# cat /etc/vault.d/vault.hcl 
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

# Full configuration options can be found at https://developer.hashicorp.com/vault/docs/configuration

api_addr = "http://192.168.10.117:8200"
cluster_addr = "https://192.168.10.117:8201"
#log_level = "trace"

ui = true

#mlock = true
disable_mlock = true

#storage "file" {
#  path = "/opt/vault/data"
#}

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}

# HTTP listener
listener "tcp" {
  address = "192.168.10.117:8200"
  cluster_address = "192.168.10.117:8201"
  tls_disable = 1
}

# HTTPS listener
#listener "tcp" {
#  address       = "0.0.0.0:8200"
#  tls_cert_file = "/opt/vault/tls/tls.crt"
#  tls_key_file  = "/opt/vault/tls/tls.key"
#}

# Enterprise license_path
# This will be required for enterprise as of v1.8
#license_path = "/etc/vault.d/vault.hclic"

# Example AWS KMS auto unseal
#seal "awskms" {
#  region = "us-east-1"
#  kms_key_id = "REPLACE-ME"
#}

# Example HSM auto unseal
#seal "pkcs11" {
#  lib            = "/usr/vault/lib/libCryptoki2_64.so"
#  slot           = "0"
#  pin            = "AAAA-BBBB-CCCC-DDDD"
#  key_label      = "vault-hsm-key"
#  hmac_key_label = "vault-hsm-hmac-key"
#}
