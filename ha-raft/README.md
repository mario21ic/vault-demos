
mkdir /opt/raft
chown vault:vault -R /opt/raft

systemctl status vault
systemctl start vault
journalctl -fu vault

Master:
```
export VAULT_ADDR='http://192.168.10.101:8200'
vault operator init -key-shares=1 -key-threshold=1
vault operator unseal
vault login
vault status
vault operator raft list-peers
```

Node2:
```
export VAULT_ADDR='http://192.168.10.102:8200'
vault operator raft join http://192.168.10.101:8200
vault operator unseal
```

Master:
```
vault operator raft list-peers
```


