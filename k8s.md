Instalar:
```
kubectl create namespace vault
kubectl --namespace='vault' get all

helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault

helm install vault hashicorp/vault --namespace vault --dry-run
helm search repo hashicorp/vault --versions

helm install vault hashicorp/vault --namespace vault --version 0.25.0

helm install -n vault vault hashicorp/vault \
    --namespace vault \
    -f override-values.yml
```

Configurar:
```
helm install vault hashicorp/vault \
    --namespace vault \
    --set "server.ha.enabled=true" \
    --set "server.ha.replicas=5" \
    --dry-run

helm install vault hashicorp/vault \
    --namespace vault \
    -f override-values.yml \
    --dry-run

#helm install vault hashicorp/vault --namespace vault -f override-values.yml
#helm upgrade vault hashicorp/vault --namespace vault -f override-values.yml
```

Listar:
```
kubectl get all -n vault
kubectl get pods --selector='app.kubernetes.io/name=vault' --namespace='vault'
```

Inicializar:
```
kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator init
```

Unseal:
```
kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator unseal # Unseal Key 1
kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator unseal # Unseal Key 2
kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator unseal # Unseal Key 3

kubectl -n vault get pods --selector='app.kubernetes.io/name=vault'
```

Dashboard:
```
kubectl -n vault port-forward vault-0 8200:8200
```

Uninstall:
```
helm -n vault uninstall vault
kubectl get all -n vault
```

Based on https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide
