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
- A Ragnerock License (Provided by Ragnerock)
- A Ragnerock service account dockerconfig (Provided by Ragnerock)

The Gemini and Mistral API keys are required for base operation, while thie Cloudflare settings are required for the web-scrape data ingestion feature. If you do not intend to use this feature, you can leave out those settings.

In this example we will be referencing those values with `$GEMINI_API_KEY`, `$MISTRAL_API_KEY`, `$CLOUDFLARE_API_TOKEN`, and `$CLOUDFLARE_ACCOUNT_ID`

### Optional Resources

If you would prefer to use an in-cluster database or bucket, see the supporting manifests conatined in our `charts/examples/minimal` directory (`pgvector` for the database and `cloudserver` for the bucket). Applying those supporting manifests will bring up the resources as well as perform the initial setup required.

> NOTE: Ragnerock does not guarantee anything regarding the usage of these in-cluster resources, they are for example purposes and are not production-grade out of the box (e.g. cloudserver does not persist data in the event of a restart)

### Configuration

Now that you have everything ready, copy the values file from `charts/examples/minimal/values.yaml` and place it wherever you want to store that for your deployment. Edit the values as follows:

- `database.host` -- hostname of your provisioned database
- `database.user` -- username to access your database
- `database.name` -- name of the database you will be using
- `database.password` -- password to access your database

Note that in the event you are using the pgvector manifest, the default values will connect OOTB

- `encryption.kek` -- The encryption key for your instance. DO NOT USE THE VALUE IN THE MANIFEST, instead generate your own with `python -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())'`

- `enpoints.HMACMasterKey` -- generate with `openssl rand -hex 22`

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
- `api.url` -- the externally accessible URL the API will live behind, e.g. `https://api-dev.ragnerock.com`
- `frontend.service.type` -- the k8s service type to deploy for the frontend, most likely `LoadBalancer` or `NodePort`
- `frontend.url` -- the externally accessible URL the frontend will live behind, e.g. `https://app-dev.ragnerock.com`

>> NOTE: If you are using http to access the ragnerock services then set api.protocol and frontend.protocl to `http`

Add your LLM API keys

- `llm.geminiApiKey` -- API key for the default Gemini agent/image summarization
- `llm.mistralApiKey` -- API key for Mistral (used for OCR and image processing)

You'll then need to configure Cloudflare if you are using the web scrape data ingestion feature of Ragnerock. If not, set these following values to `not_implemented` (or any other placeholder value you desire)

- `cloudflare.apiToken` -- API token with the `Account.Browser Rendering` permissions granted
- `cloudflare.accountId` -- ID of the Cloudflare account associated with the API token

Finally configure your license

- `license` -- The License provided by Ragnerock

### Deployment

First deploy your imagePullSecret:

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ragnerock-image-pull-secret
  namespace: default
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: <YOUR RAGNEROCK PROVIDED SERVICE ACCOUNT DOCKERCONFIG>
EOF
```

Now that you have configured your values (we will assume they live at `./values.yaml` for this example) and configured your image pull secret, you can deploy Ragnerock to your cluster with

```
helm repo add ragnerock https://ragnerock.github.io/ragnerock-k8s
helm upgrade --install ragnerock ragnerock/ragnerock --values ./values.yaml
```

After installation you will see the URLs for each Ragnerock service printed as well as the externally accessible URLs to access the application

### First-time Setup

Now that you have deployed Ragnerock, investigate the API logs and look for the following log line:

```
============================================================
INITIAL ADMIN CREDENTIALS \u2014 RECORD THESE NOW
============================================================
email:    admin@localhost.local
password: <your admin password>
    
Login with the admin credentials to finish setting up\n  your system. You will be prompted to set a new password\n  on first login. This message will not be shown again.
============================================================
```

Login to your Ragnerock instance with the admin credentials provided. You will then be prompted to change the admin password and subsequently redirected to the application

**Bring Your Own AI (BYOAI)**

If you want to use a different AI provider from the default Gemini, click on the profile on the bottom left and select `Settings` from the menu that appears. From within the settings page, click on `AI Providers` from the integrations menu to bring up the BYOAI configuration screen. Click on `Add Provider` and fill out the configuration modal with your AI provider information. You can explicitly test a configuration with the `Test Configuration` button, however tests will run as part of the provider creation as well once you click on `Create Configuration`. Once the configuration has been created, click on the `...` to the right of your configuration and select `Activate` to make this your default AI provider.

**Bring Your Own Database (BYODB)**

If you want to store your non-application (e.g. job statuses, configurations) data in a separate database from Ragnerock, click on the profile button on the bottom left and select `Settings` from the menu that appears. From within the settings page, click on `Databases` under the interations menu to bring up the BYODB configuration screen. Fill out the configuration modal and click on `Create Configuration` to create your database configuration. After doing so, click on the `Initialize` button next to your configuration to initialize the database schema that is required by Ragnerock. After this has completed, click on the `...` to the right of your configuration and select `Activate` to make this your default database provider.

**Bring Your Own Blob Storage**

To configure the location which Ragnerock will store raw document files, click on the profile button on the bottom left and select `Settings` from the menu that appears. From within the settings page, click on `Storage` under the integrations menu to bring up the BYOBS configuration screen. Click on `Add Storage` to bring up the configuration modal. Configure your blob storage as desired (GCP bucket, S3, or Azure blob storage) and click on `Create Configuration`. Once the configuration has been created, click on the `Validate` button to the right of your configuration to setup the bucket and validate the configuration. Finally, clickj on the `...` to the right of your configuration and select `Activate` to begin using the blob storage provider.