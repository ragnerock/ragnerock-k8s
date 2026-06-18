# Ragnerock Minimal Install

Minimal, fully in-cluster install of Ragnerock on Kubernetes. No GCP-managed
services are used: Postgres, the Cloud Tasks queue, and blob storage all run
inside the cluster. AI is BYOAI — Ragnerock does not ship a default Gemini
account; you supply your own keys at install time and/or via the workspace
admin UI after install.

## What gets deployed

| Component         | Source                              |
| ----------------- | ----------------------------------- |
| Postgres + vector | `pgvector.yaml` (StatefulSet)       |
| S3-compatible blob storage | `cloudserver.yaml` (Zenko CloudServer + bucket-init Job) |
| API / worker / subtask-worker / model-service / analysis-toolkit / data-ingestor / frontend / migrations/ queue service | The `ragnerock` chart |

There is no GCS bucket, no Cloud SQL instance, no Cloud Tasks project. The
chart's default blob path falls back to in-pod `LocalBlobStorage`, which is
not shared across pods — point Ragnerock at the in-cluster
S3-compatible CloudServer via BYOBS (see below) so uploads, parsing, and
search all see the same documents.

## BYOBS: in-cluster S3 storage

`cloudserver.yaml` runs [Zenko CloudServer](https://github.com/scality/cloudserver)
in the cluster and seeds a `mybucket` bucket. Configure it as the workspace
blob storage backend from the admin UI after install:

| Field         | Value                          |
| ------------- | ------------------------------ |
| Provider      | S3 / S3-compatible             |
| Endpoint URL  | `http://cloudserver:8000`      |
| Region        | `us-west-2`                    |
| Bucket name   | `mybucket`                     |
| Access key ID | `test` (from `cloudserver` Secret) |
| Secret access key | `test` (from `cloudserver` Secret) |

Replace the test credentials in `cloudserver.yaml` for anything beyond a
demo install.

## Required LLM Keys

The model-service used Gemini-specific embeddings, as such a Gemini API key (set to `GEMINI_API_KEY` in our examples) is required
Additionally, Mistral is required for PDF parsing, so a Mistral API key (set to `MISTRAL_API_KEY` in our examples) is also required

Agent/operator LLMs are configurable with respect to the provider and can be configured in-app via the BYOAI functionality

## Required Cloudflare credentials

The `data-ingestor` service uses Cloudflare's browser-rendering API for web
scraping, so a Cloudflare API token (set to `CLOUDFLARE_API_TOKEN` in our
examples) and the matching account ID (set to `CLOUDFLARE_ACCOUNT_ID`) are
required for the pod to start. Both are passed via `--set` on install.

## Install

Apply the supporting manifests, then install the chart:

```bash
kubectl apply -f ./charts/examples/minimal/pgvector.yaml
kubectl apply -f ./charts/examples/minimal/cloudserver.yaml

helm upgrade --install ragnerock ./charts/ragnerock \
  --values ./charts/examples/minimal/values.yaml \
  --set llm.geminiApiKey=$GEMINI_API_KEY \
  --set llm.mistralApiKey=$MISTRAL_API_KEY \
  --set dataIngestor.cloudflare.apiToken=$CLOUDFLARE_API_TOKEN \
  --set dataIngestor.cloudflare.accountId=$CLOUDFLARE_ACCOUNT_ID
```

After the pods are healthy, Ragnerock is reachable at
[http://localhost:3000](http://localhost:3000) (frontend) and
[http://localhost:8080](http://localhost:8080) (API), assuming your cluster
exposes `LoadBalancer` services on localhost