# Ragnerock K8s

This repository contains kubernetes deployment resources for Ragnerock on-prem

Currently, we only support using Helm to install the application.

## Getting Started

### Prerequisites

In order to install Ragnerock, you'll need the following

- Gemini API key
- Mistral API key
- Cloudflare API token (optional)
- Cloudflare account ID (optional)
- An S3, GCS, or Azure bucket
- A postgres database with the `vector` and `uuid-ossp` extensions installed

The Gemini and Mistral API keys are required for base operation, while thie Cloudflare settings are required for the web-scrape data ingestion feature. If you do not intend to use this feature, you can leave out those settings.

In this example we will be referencing those values with `$GEMINI_API_KEY`, `$MISTRAL_API_KEY`, `$CLOUDFLARE_API_TOKEN`, and `$CLOUDFLARE_ACCOUNT_ID`

### Optional Resources

If you would prefer to use an in-cluster database or bucket, see the supporting manifests conatined in our `charts/examples/minimal` directory (`pgvector` for the database and `cloudserver` for the bucket). Applying those supporting manifests will bring up the resources as well as perform the initial setup required.

> NOTE: Ragnerock does not guarantee anything regarding the usage of these in-cluster resources, they are for example purposes and are not production-grade out of the box (e.g. cloudserver does not persist data in the event of a restart)

### Configuration

Now that you have everything ready, copy the values file from `charts/examples/minimal/values.yaml` and place it whereever you want to store that for your deployment. Edit the values as follows:

- `database.host` -- hostname of your provisioned database
- `database.user` -- username to access your database
- `database.name` -- name of the database you will be using
- `database.password` -- password to access your database

Note that in the event you are using the pgvector manifest, the default values will connect OOTB

- `encryption.kek` -- The encryption key for your instance. DO NOT USE THE VALUE IN THE MANIFEST, instead generate your own with `python -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())'`

- `auth.secretKey` -- generate with `openssl rand -hex 22`
- `auth.accessKey` -- generate with `openssl rand -hex 22`

Choose an identifier for your deployment, generally `ragnerock` is acceptable but you may wish to change it to a different value depending on your situation

- `config.environmentIdentifier` -- whatever idenfifier you decide on

If you wish to configure OTEL for monitoring your deployment, set the following configuration

- `otel.enabled` -- set to `true` to enable logs/metrics/traces
- `otel.exporterEndpoint` -- your OTEL collector instance, for example, with self-hosted Grafana (single-container with a `lgtm` DNS entry) you would use `http://lgtm:4318`
- `otel.exporterInsecure` -- only set to `true` if you're using something like self-hosted Grafana
- `otel.exporterProtocol` -- protocol to send traces/metrics/logs with
- `otel.authHeader` -- if you are not using an unsecured (i.e. locally deployed dev instance) OTEL collector, set this to `Authorization=Basic%20<your auth token>`

You'll also have to confiugre your API and frontend services to ensure they can properly talk to each other

- `api.service.type` -- the k8s service type to deploy for the API, most likely `LoadBalancer` or `NodePort`
- `api.fqdn` -- the externally accessible URL the API will live behind, e.g. `api-dev.ragnerock.com`
- `frontend.service.type` -- the k8s service type to deploy for the frontend, most likely `LoadBalancer` or `NodePort`
- `frontend.fqdn` -- the externally accessible URL the frontend will live behind, e.g. `app-dev.ragnerock.com`

Finally configure your license by setting it to the license value provided by Ragnerock

### Deployment

Now that you have configured your values (we will assume they live at `./values.yaml` for this example), you can deploy Ragnerock to your cluster with

```
helm repo add ragnerock https://ragnerock.github.io/ragnerock-k8s
helm upgrade --install ragnerock ragnerock/ragnerock \
--values ./values.yaml \
--set llm.geminiApiKey=$GEMINI_API_KEY \
--set llm.mistralApiKey=$MISTRAL_API_KEY \
--set cloudflare.apiToken=$CLOUDFLARE_API_TOKEN \
--set cloudflare.accountId=$CLOUDFLARE_ACCOUNT_ID
```

After installation you will see the URLs for each Ragnerock service printed as well as the externally accessible URLs to access the application