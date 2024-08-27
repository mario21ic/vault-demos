```
vault server -dev

vault secrets list
vault secrets enable -path=kv/ kv

vault kv put kv/hello target=world
vault kv put kv/my-secret vault="s3cret"
vault kv get kv/my-secret


vault kv list kv/

vault secrets disable kv/
vault kv list kv/

vault kv list secret/
vault secrets list
```

based on https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-secrets-engines
