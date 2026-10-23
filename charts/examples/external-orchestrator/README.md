# Ragnerock with Dagster as its orchestrator

These values set up a Ragnerock install whose workflow runs are driven by Dagster, with both running on Kubernetes. The full guide is [docs/features/external-orchestrators/dagster.md](../../../../docs/features/external-orchestrators/dagster.md).

| File | For |
| ---- | --- |
| `values.yaml` | The `ragnerock` chart: makes the install's orchestrator external. Layer it over your other values. |
| `dagster-values.yaml` | Dagster's own chart (`dagster/dagster`, checked against 1.13.26): adds a code location that runs the Ragnerock adapter, with its tokens mounted from a Secret. |

## 1. Install or upgrade Ragnerock

Start from your existing values (for a new install, see [`../minimal`](../minimal/README.md)) and add `values.yaml`:

```bash
helm upgrade --install ragnerock ./charts/ragnerock \
  --namespace ragnerock \
  -f my-values.yaml \
  -f charts/examples/external-orchestrator/values.yaml
```

From then on, new runs started from the app, the API, schedules or agents wait for Dagster. Endpoint calls and the runs that uploads and ingests start still run on Ragnerock's own orchestrator, as `orchestrator.builtinTriggers` lists. If Dagster reaches Ragnerock through an ingress or a load balancer rather than the in-cluster Service, route `/execution/v1/*` to the API as well as `/api/*`, and let requests stay idle for more than 25 seconds.

## 2. Create the tokens

In Ragnerock, as an account admin:

- **Admin → Orchestrator → Driver tokens → Create token.** Copy the token; it is shown once.
- Optionally, to start Ragnerock workflows from Dagster schedules: **Settings → API tokens**, as a user who can run those workflows.

Store them in a Secret in Dagster's namespace, under the keys the values file mounts:

```bash
kubectl create secret generic ragnerock-tokens \
  --namespace dagster \
  --from-literal=driver-token="$RAGNEROCK_DRIVER_TOKEN" \
  --from-literal=api-token="$RAGNEROCK_API_TOKEN"
```

Without an API token, leave out the `api-token` key, and remove `RAGNEROCK_API_TOKEN_FILE` from `dagster-values.yaml`.

## 3. Build the code location image

The code location runs on Python 3.12 or later. It needs the adapter, and the Dagster libraries the chart's run launcher and storage use, at the versions that match your Dagster:

```dockerfile
FROM python:3.12-slim
ARG DAGSTER_VERSION=1.13.26
RUN pip install --no-cache-dir \
    "dagster==${DAGSTER_VERSION}" dagster-postgres dagster-k8s \
    ragnerock-orchestrator-dagster
```

Push it, and set `image.repository` and `image.tag` in `dagster-values.yaml` to match.

## 4. Install or upgrade Dagster

Set `RAGNEROCK_URL` and `DAGSTER_WEBSERVER_URL` in `dagster-values.yaml`, then:

```bash
helm repo add dagster https://dagster-io.github.io/helm
helm upgrade --install dagster dagster/dagster \
  --namespace dagster \
  -f charts/examples/external-orchestrator/dagster-values.yaml
```

The values also turn on Dagster's run retries, so a run whose worker crashes resumes with the same Ragnerock run.

## 5. Turn the sensors on

In Dagster's UI, under **Automation**, turn on `ragnerock_dispatch_sensor` and `ragnerock_run_canceled_sensor`. Then start a run in Ragnerock: within about ten seconds, a run of `ragnerock_dispatch_run` appears in Dagster, and the job in Ragnerock shows a **Dagster** badge linking to it.
