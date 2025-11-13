# GKE Advanced Deployment Lab

End-to-end lab: Terraform (VPC + GKE + Artifact Registry) → GitHub Actions (OIDC) → Helm deploys (Gateway API, NEGs) → Loki logging, Prometheus (kube-prometheus-stack) → k6 load test.

## Quick start

### 1) Provision infra
```bash
cd infra
terraform init
terraform apply -auto-approve   -var="project_id=YOUR_PROJECT"   -var="region=asia-south1"   -var="zone=asia-south1-a"
```

### 2) Connect to cluster
```bash
gcloud container clusters get-credentials gke-adv --zone asia-south1-a --project YOUR_PROJECT
```

### 3) Install monitoring & logging
```bash
# Prometheus + Grafana
bash scripts/install_prometheus.sh
kubectl apply -f grafana/dashboards/configmap.yaml

# Loki + Alloy (agent)
bash scripts/install_loki.sh
```

> Grafana admin: `admin/admin` (set in `prometheus/values.yaml`). Port-forward if needed:  
> `kubectl -n monitoring port-forward svc/kube-prom-grafana 3000:80` then open http://localhost:3000

### 4) Gateway API (L7) & L4 pass-through
- Put your TLS cert/key (base64) into `manifests/gateway.yaml` or replace the Secret with your cert-manager flow.  
- Apply:
```bash
kubectl apply -f manifests/gateway.yaml
```

### 5) GitHub Actions → GCP (keyless)
- Create a Workload Identity Federation pool/provider; grant deploy permissions to a GSA.  
- Add repo **Secrets**:
  - `GCP_WIF_PROVIDER`
  - `GCP_WIF_SA_EMAIL`
- Add repo **Variables**:
  - `GCP_PROJECT`, `GCP_REGION`, `GCP_ZONE`

### 6) Build & Deploy
- Push to `main` → CI builds & pushes images to Artifact Registry → CD deploys via Helm.  
- Check:
```bash
kubectl get gateway,httproute,svc,deploy,hpa,pdb -A
```

### 7) Load test (k6)
- After your Gateway has an address/hostname:
```bash
bash scripts/loadtest_k6.sh https://example.yourdomain.com
```

## Notes
- Services include NEG annotations for container-native LB.
- `telemetry-l4` service demonstrates L4 pass-through (preserves client IP with `externalTrafficPolicy: Local`).
- Adjust retention and resources in `loki/` and `prometheus/values.yaml` for production.
