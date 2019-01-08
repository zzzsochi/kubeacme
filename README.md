# SSL with Let's Encrypt to kubernates secrets

Uses the [acme.sh](https://github.com/Neilpang/acme.sh).

## Usage

```yaml
---
kind: CronJob
apiVersion: batch/v1beta1
metadata:
  name: update-gate-ssl

spec:
  schedule: "0 0 * * 1"
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
          - name: updater
            image: zzzsochi/kubeacme
            args: ["--dns", "dns_dgon",
                   "-d", "zelenyak.name",
                   "-d", "*.zelenyak.name"]
            env:
            - name: KUBE_TOKEN
              valueFrom:
                secretKeyRef:
                  name: drone-token-kxbqc
                  key: token
            - name: KUBE_SECRET_NAME
              value: gate-ssl
            - name: DO_API_KEY
              valueFrom:
                secretKeyRef:
                  name: digitalocean
                  key: key
```

## /usr/local/bin/kubesetup

Setup ``kubectl``. Need to set ``KUBE_TOKEN`` variable.

```bash
docker run -it --rm -e KUBE_TOKEN=$(kubectl get secret my-super-token -o jsonpath='{.data.token}') zzzsochi@kubeawsctl
kubesetup
kubectl get all
```

Variable ``KUBE_SERVER`` set the kubernates server. Default: ``https://kubernetes.default.svc.cluster.local``

## /usr/local/bin/kubeacme

Need to set ``KUBE_SECRET_NAME``.
All arguments passed to [acme.sh](https://github.com/Neilpang/acme.sh).
