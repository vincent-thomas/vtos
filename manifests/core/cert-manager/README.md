If cloning.

Add

```yaml
# File: secret.yaml

apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token
type: Opaque
stringData:
  api-token: [secret]
```

Permissions:

- Zone - DNS - Edit
- Zone - Zone - Read

Zone resources:
Include - All Zones
