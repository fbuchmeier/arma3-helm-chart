## Helm

```
helm-docs .
convco ...
for i in ./test-values ; do
    helm template --debug --values $i . || echo "ERROR: Failed templating $i
done
```

## Docker
