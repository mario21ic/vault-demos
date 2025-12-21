Install following https://developer.hashicorp.com/vault/install?product_intent=vault

Single server no dev:

Disable https listener on /etc/vault.d/vault.hcl
```
api_addr = "http://192.168.2.51:8200"
listener "tcp" {
  address = "192.168.2.51:8200"
  tls_disable = 1
}
disable_mlock = true
```

Add on /etc/vauld.d/vault.env
```
VAULT_API_ADDR=http://192.168.2.51:8200
```

Init:
```
export VAULT_ADDR=http://192.168.2.51:8200
vault operator init
```

Browser: http://ip-server:8200
initial root token: hvs.xxxxx
key 1: xxx=


```
vault secrets enable -path=secret/ kv
vault kv put secret/hello foo=world
vault kv put secret/hello foo=world excited=yes
```

Get:
```
vault kv get secret/hello
vault kv get -field=excited secret/hello

vault kv get -format=json secret/hello
vault kv get -format=json secret/hello | jq -r .data
```


Delete:
```
vault kv delete secret/hello
```

Based on https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-first-secret
