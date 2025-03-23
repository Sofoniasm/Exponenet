# Terraform OpenStack RKE2

## Terraform Registry

Easily deploy a high-availability RKE2 Kubernetes cluster on OpenStack providers (e.g., Infomaniak, OVH, etc.). This project aims to offer a simple and stable distribution rather than supporting all configuration possibilities.

Inspired and reworked from [remche/terraform-openstack-rke2](https://github.com/remche/terraform-openstack-rke2) to add an easier interface, high-availability, load-balancing, and sensible defaults for running production workloads.

## Features

- **RKE2 Kubernetes distribution**: Lightweight, stable, simple, and secure.
- **Persisted `/var/lib/rancher/rke2`** when there is a single server.
- **Automated etcd snapshots** with OpenStack Swift support or other S3-like backends.
- **Smooth updates & agent nodes auto-removal** with pod draining.
- **Integrated OpenStack Cloud Controller** (load-balancer, etc.) and Cinder CSI.
- **Cilium networking** (network policy support and no kube-proxy).
- **Highly available** via kube-vip and dynamic peering (no load-balancer required).
- **Out-of-the-box support** for volume snapshots and Velero.

### Added Features

- **Ingress Observability**: Implementation of ingress controllers with enhanced observability features.
- **OpenTelemetry (OTEL) Collector**: Centralized collection of metrics and logs from Kubernetes workloads.
- **OTELApp Demo**: A demo application integrated with OpenTelemetry to visualize the observability stack.
- **Jaeger**: Distributed tracing system for monitoring and troubleshooting microservices-based applications.
- **Prometheus**: Open-source monitoring system for gathering metrics from your Kubernetes environment.
- **Grafana**: Visualization tool integrated with Prometheus to display custom dashboards for monitoring your clusters.

## Versioning

| Component                     | Version              |
| ----------------------------- | -------------------- |
| OpenStack                     | 2023.1 Antelope (verified) |
| RKE2                          | v1.29.0+rke2r1       |
| OpenStack Cloud Controller    | v1.28.1              |
| OpenStack Cinder              | v1.28.1              |
| Velero                        | v6.0.0               |
| Kube-vip                      | v0.7.2               |
| Prometheus                    | v2.41.0              |
| Grafana                       | v9.5.2               |
| Jaeger                        | v1.44.0              |

## Getting Started

Clone the repository and configure your environment as described below:

```bash
git clone git@github.com:zifeo/terraform-openstack-rke2.git && cd terraform-openstack-rke2/examples/single-server
cat <<EOF > terraform.tfvars
project=PCP-XXXXXXXX
username=PCU-XXXXXXXX
password=XXXXXXXX
EOF

terraform init
terraform apply # approx 2-3 mins
kubectl --kubeconfig single-server.rke2.yaml get nodes

