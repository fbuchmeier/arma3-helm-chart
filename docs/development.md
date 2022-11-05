# Development

## minikube

To deploy and test the chart, you can use
[minikube](https://minikube.sigs.k8s.io/docs/start/).

### Setup

```sh
kubectl create ns arma3
```

```sh
STEAM_USER=bob
STEAM_PASSWORD=abc
TEST_VALUES=rwo-rwo.yaml
RELEASE=arma3-${TEST_VALUES/".yaml"/}

helm upgrade --install "$RELEASE" . -n arma3 \
    -f test-values/"$TEST_VALUES" \
    --set credentials.steamUser="$STEAM_USER" \
    --set credentials.steamPassword="$STEAM_PASSWORD"
```

```sh
watch kubectl get pods -n arma3
```

### Teardown

Uninstall helm release:

```sh
helm uninstall -n arma3 "$RELEASE"
```

Cleanup any unused volumes belonging to this release (copy and paste the output
command when satisfied):

```sh
echo kubectl delete pv $(
    kubectl get pv -o json \
        | jq -r --arg release "$RELEASE" \
        '.items[] | select( .spec.claimRef.name | contains($release) ) | .metadata.name'
    )
```

## Helm

Run linting:

```sh
make validate
```

Test against snapshots:

```sh
make test
```

Update snapshots:

```sh
make snapshot
```

Generate docs:

```sh
make release
```
