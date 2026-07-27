# ragnerock

![Version: 1.2.0](https://img.shields.io/badge/Version-1.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2026.07.13](https://img.shields.io/badge/AppVersion-v2026.07.13-informational?style=flat-square)

Ragnerock research intelligence platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agent.maxIterations | int | `10` |  |
| analysis.dataframeOpTimeout | int | `60` |  |
| analysis.maxColumns | int | `500` |  |
| analysis.maxRows | int | `50000` |  |
| analysis.modelFitTimeoutSeconds | int | `120` |  |
| analysis.plotDPI | int | `150` |  |
| analysis.plotMaxFigsize.dimx | float | `12` |  |
| analysis.plotMaxFigsize.dimy | float | `16` |  |
| analysis.plotTimeoutSeconds | int | `60` |  |
| analysisToolkit.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| analysisToolkit.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| analysisToolkit.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| analysisToolkit.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| analysisToolkit.image.name | string | `"analysis-toolkit"` |  |
| analysisToolkit.image.tag | string | `""` | Overwrites global value if set |
| analysisToolkit.replicaCount | int | `1` |  |
| analysisToolkit.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| analysisToolkit.service.port | int | `8080` |  |
| analysisToolkit.service.type | string | `"ClusterIP"` |  |
| analysisToolkit.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| analysisToolkit.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| analysisToolkit.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| analysisToolkit.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| analysisToolkit.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| analysisToolkit.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| api.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| api.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| api.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| api.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| api.image.name | string | `"api"` |  |
| api.image.tag | string | `""` |  |
| api.replicaCount | int | `1` |  |
| api.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| api.service.port | int | `8080` |  |
| api.service.type | string | `"ClusterIP"` |  |
| api.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| api.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| api.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| api.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| api.url | string | `""` |  |
| api.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| api.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| audit.batchMaxBytes | int | `819200` |  |
| audit.batchMaxEvents | int | `50` |  |
| audit.drainTimeoutSeconds | float | `8` |  |
| audit.emitEnabled | bool | `true` |  |
| audit.errorMessageMaxChars | int | `2000` |  |
| audit.eventMaxBytes | int | `512000` |  |
| audit.flushIntervalSeconds | float | `2` |  |
| audit.kwargsSummaryMaxKeys | int | `50` |  |
| audit.listLimitCap | int | `200` |  |
| audit.payloadFieldMaxBytes | int | `204800` |  |
| audit.promptPreviewMaxChars | int | `500` |  |
| audit.queueMaxBytes | int | `134217728` |  |
| audit.queueMaxEvents | int | `10000` |  |
| audit.resnapshotTurns | int | `10` |  |
| auditService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| auditService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| auditService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| auditService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| auditService.export.lagAlertMinutes | int | `120` | Oldest-incomplete-window age past which the scan logs a lag alert |
| auditService.export.scanLookbackHours | int | `26` | Bounded catch-up horizon the export scan considers for missing windows |
| auditService.export.watermarkMinutes | int | `15` | Ingest-lag settle time before an export window is declared complete |
| auditService.image.name | string | `"audit-service"` |  |
| auditService.image.tag | string | `""` | Overwrites global value if set |
| auditService.partitionPrecreateMonths | int | `3` | Months of partitions `/audit/maintain` keeps ahead of ingest on each daily run |
| auditService.replicaCount | int | `1` |  |
| auditService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| auditService.service.port | int | `8080` |  |
| auditService.service.type | string | `"ClusterIP"` |  |
| auditService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| auditService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| auditService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| auditService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| auditService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| auditService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| auth.accessCodeExpireMinutes | int | `10080` |  |
| auth.accessKey | string | `""` | Generate with `openssl rand -hex 22` |
| auth.accessTokenExpireMinutes | int | `10080` |  |
| auth.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `SECRET_KEY` and `ACCESS_KEY`) instead of generating one. When set, `secretKey`/`accessKey` are ignored. |
| auth.lockoutMaxAttempts | int | `10` |  |
| auth.secretKey | string | `""` | Generate with `openssl rand -hex 22` |
| callbackDelivery.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| callbackDelivery.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| callbackDelivery.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| callbackDelivery.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| callbackDelivery.image.name | string | `"api"` |  |
| callbackDelivery.image.tag | string | `""` |  |
| callbackDelivery.replicaCount | int | `1` |  |
| callbackDelivery.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| callbackDelivery.service.port | int | `8080` |  |
| callbackDelivery.service.type | string | `"ClusterIP"` |  |
| callbackDelivery.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| callbackDelivery.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| callbackDelivery.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| callbackDelivery.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| callbackDelivery.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| callbackDelivery.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| cloudflare.accountId | string | `""` |  |
| cloudflare.apiToken | string | `""` |  |
| cloudflare.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`) instead of generating one. When set, `apiToken`/`accountId` are ignored. |
| config | object | `{"environmentIdentifier":"ragnerock","logLevel":"INFO"}` | General app configuration |
| dataIngestor.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| dataIngestor.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| dataIngestor.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| dataIngestor.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| dataIngestor.image.name | string | `"data-ingestor"` |  |
| dataIngestor.image.tag | string | `""` |  |
| dataIngestor.replicaCount | int | `1` |  |
| dataIngestor.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| dataIngestor.service.port | int | `8080` |  |
| dataIngestor.service.type | string | `"ClusterIP"` |  |
| dataIngestor.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| dataIngestor.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| dataIngestor.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| dataIngestor.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| dataIngestor.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| dataIngestor.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| database | object | `{"existingSecret":"","host":"","maxOverflow":40,"name":"ragnerock","password":"","poolSize":20,"poolTimeout":10,"port":5432,"user":"ragnerock"}` | Database configuration |
| database.existingSecret | string | `""` | Use a pre-existing secret (must provide key `DB_PASSWORD`) instead of generating one. When set, `password` is ignored. |
| db.timeout.connect | float | `10` |  |
| db.timeout.pool | float | `10` |  |
| db.timeout.queryRead | float | `120` |  |
| db.timeout.read | float | `60` |  |
| db.timeout.write | float | `10` |  |
| dbService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| dbService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| dbService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| dbService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| dbService.batchLimit | int | `10000` |  |
| dbService.connectionFailureThreshold | int | `5` | Consecutive connection failures before a config is flagged for deactivation |
| dbService.image.name | string | `"db-service"` |  |
| dbService.image.tag | string | `""` | Overwrites global value if set |
| dbService.rateLimitMaxTokens | int | `100` | Per-customer-DB rate limit: token bucket capacity (the default data DB is exempt) |
| dbService.rateLimitRefillRate | float | `20` | Per-customer-DB rate limit: token refill rate (tokens per second) |
| dbService.replicaCount | int | `1` |  |
| dbService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| dbService.service.port | int | `8080` |  |
| dbService.service.type | string | `"ClusterIP"` |  |
| dbService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| dbService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| dbService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| dbService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| dbService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| dbService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| encryption.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENCRYPTION_KEK`) instead of generating one. When set, `kek` is ignored. |
| encryption.kek | string | `""` | Key Encryption Key (KEK), generate with python -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())' |
| endpoints.HMACMasterKey | string | `""` |  |
| endpoints.allowPrivateCallbacks | bool | `true` |  |
| endpoints.ephemeralTTLHours | int | `24` |  |
| endpoints.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENDPOINTS_HMAC_MASTER_KEY`) instead of generating one. When set, `HMACMasterKey` is ignored. |
| endpoints.maxFileSizeMB | int | `50` |  |
| frontend.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| frontend.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| frontend.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| frontend.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| frontend.image.name | string | `"frontend"` |  |
| frontend.image.tag | string | `""` |  |
| frontend.replicaCount | int | `1` |  |
| frontend.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| frontend.service.port | int | `3000` |  |
| frontend.service.type | string | `"ClusterIP"` |  |
| frontend.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| frontend.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| frontend.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| frontend.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| frontend.url | string | `""` |  |
| frontend.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| frontend.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| fullnameOverride | string | `nil` |  |
| global.annotations | object | `{}` | Default annotations applied to the metadata of all workloads (Deployments/Job). Merged with per-service `<service>.annotations`, where per-service keys take precedence. |
| global.image | object | `{"pullPolicy":"IfNotPresent","registry":"us-central1-docker.pkg.dev/ragnerock-prod/ragnerock","tag":""}` | Global container image configuration |
| global.image.tag | string | `""` | Default image tag for all services. When empty, falls back to the chart's appVersion. |
| global.imagePullSecrets | list | `[]` | Secrets use to authenticate with the container registry, list of `- name: <name of the secret>` values |
| global.revisionHistoryLimit | int | `10` | Number of replicaset revisions to keep around for deployments |
| global.tolerations | list | `[]` | Default pod tolerations applied to all workloads. Can be overridden per-service with `<service>.tolerations`. See https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| iam | object | `{"permissionsCacheTTL":60}` | Identity and access management |
| iam.permissionsCacheTTL | int | `60` | Seconds a resolved IAM permission set is cached in-process |
| ingest.staleTimeoutSeconds | int | `3600` |  |
| license | string | `""` | Ragnerock provided license key |
| licenseExistingSecret | string | `""` | Use a pre-existing secret (must provide key `RAGNEROCK_LICENSE`) instead of generating one. When set, `license` is ignored. |
| limits.batches.annotation | int | `50` |  |
| limits.batches.defaultRow | int | `50` |  |
| limits.batches.embedding | int | `100` |  |
| limits.batches.tabularAnnotation | int | `200` |  |
| limits.codeOperator.timeoutSeconds | int | `30` | Wall-clock ceiling for a code operator's execution, in seconds |
| limits.concurrency.maxConcurrentAnnotations | int | `10` |  |
| limits.concurrency.maxConcurrentJobs | int | `10` |  |
| limits.concurrency.maxConcurrentSubtasks | int | `50` |  |
| limits.job.watchdogSlackMinutes | int | `5` | Extra delay past the subtask stale threshold before the job watchdog reconciles |
| limits.subtask.failureThreshold | float | `0.05` |  |
| limits.subtask.maxAttempts | int | `3` |  |
| limits.subtask.staleThresholdMinutes | int | `35` | Minutes without a heartbeat before an in-flight subtask may be re-claimed |
| limits.usage.maxComputeSeconds | string | `"86400"` |  |
| limits.usage.maxInputTokens | string | `"1000000"` |  |
| limits.usage.maxOutputTokens | string | `"1000000"` |  |
| limits.usage.maxPages | string | `"2000"` |  |
| llm | object | `{"azure":{"apiKey":"","endpoint":""},"existingSecret":"","gemini":{"apiKey":""},"mistral":{"apiKey":""},"pdfExtractImages":true,"pdfParserBackend":"mistral","textract":{"accessKeyId":"","existingSecret":"","maxConcurrency":4,"region":"","secretAccessKey":""}}` | LLM authentication configuration |
| llm.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `GEMINI_API_KEY` and `MISTRAL_API_KEY`) instead of generating one. When set, `geminiApiKey`/`mistralApiKey` are ignored. |
| llm.pdfExtractImages | bool | `true` | Extract embedded images from PDFs during parsing (for multimodal summarization) |
| llm.pdfParserBackend | string | `"mistral"` | PDF parsing backend: `mistral`, `azure`, or `textract` |
| llm.textract.accessKeyId | string | `""` | AWS access key ID. Required when `pdfParserBackend` is `textract`. |
| llm.textract.existingSecret | string | `""` | Use a pre-existing secret (must provide key `AWS_SECRET_ACCESS_KEY`) instead of generating one. When set, `secretAccessKey` is ignored. |
| llm.textract.maxConcurrency | int | `4` | Maximum concurrent Textract page requests per worker |
| llm.textract.region | string | `""` | AWS region the Textract API is called in. Required when `pdfParserBackend` is `textract`. |
| llm.textract.secretAccessKey | string | `""` | AWS secret access key. Required when `pdfParserBackend` is `textract`. |
| migrations.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| migrations.image.name | string | `"migrations"` |  |
| migrations.image.tag | string | `""` |  |
| migrations.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| migrations.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| migrations.serviceAccount.create | bool | `false` | Create a service account for the migrations job's pods |
| migrations.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| migrations.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| model.geminiModelName | string | `"gemini-3-flash-preview"` |  |
| model.httpTimeoutSeconds | int | `180` |  |
| modelService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| modelService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| modelService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| modelService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| modelService.image.name | string | `"model-service"` |  |
| modelService.image.tag | string | `""` |  |
| modelService.replicaCount | int | `1` |  |
| modelService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| modelService.service.port | int | `8080` |  |
| modelService.service.type | string | `"ClusterIP"` |  |
| modelService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| modelService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| modelService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| modelService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| modelService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| modelService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| nameOverride | string | `nil` |  |
| otel | object | `{"authHeader":"","enabled":false,"existingSecret":"","exporterEndpoint":"","exporterInsecure":false,"exporterProtocol":"http/protobuf"}` | Otel metrics/traces/logs export |
| otel.existingSecret | string | `""` | Use a pre-existing secret (must provide key `OTEL_EXPORTER_OTLP_HEADERS`) instead of generating one. When set, `authHeader` is ignored. |
| python | object | `{"batchChunkItems":16,"maxAttempts":4,"maxRequestBytes":48000000,"timeoutMarginSeconds":60}` | Client-side knobs used by callers of python-service (API and workers). The sandbox's own configuration lives under `pythonService.sandbox`. |
| python.batchChunkItems | int | `16` | Items per chunk when a batch execution is split across requests |
| python.maxAttempts | int | `4` | Attempts per execution request before giving up |
| python.maxRequestBytes | int | `48000000` | Request payload ceiling enforced before send, in bytes |
| python.timeoutMarginSeconds | float | `60` | Seconds added to the execution budget to form the HTTP read timeout |
| pythonService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| pythonService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| pythonService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| pythonService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| pythonService.image.name | string | `"python-service"` |  |
| pythonService.image.tag | string | `""` | Overwrites global value if set |
| pythonService.replicaCount | int | `1` |  |
| pythonService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| pythonService.sandbox | object | `{"batchStartupGraceSeconds":15,"enforcement":"on","maxOutputBytes":1000000,"maxRequestBytes":48000000,"maxResultBytes":8000000,"maxTimeout":30,"recycleAfterNExecutions":100,"rlimitCPUSeconds":60,"rlimitFSizeBytes":64000000,"rlimitNProc":512,"rlimitNoFile":256}` | Sandbox limits the code-execution service applies to user code |
| pythonService.sandbox.batchStartupGraceSeconds | float | `15` | Extra wall-clock allowed for subprocess spawn and the first heavy import |
| pythonService.sandbox.enforcement | string | `"on"` | `on` requires the Linux sandbox mechanisms; `off` is a local-dev escape hatch only |
| pythonService.sandbox.maxOutputBytes | int | `1000000` | stdout/stderr capture cap, in bytes |
| pythonService.sandbox.maxRequestBytes | int | `48000000` | Request payload ceiling enforced on receipt, in bytes |
| pythonService.sandbox.maxResultBytes | int | `8000000` | Per-result size ceiling, in bytes |
| pythonService.sandbox.maxTimeout | int | `30` | Wall-clock ceiling applied to every execution, in seconds |
| pythonService.sandbox.recycleAfterNExecutions | int | `100` | Exit cleanly after this many executions; <= 0 disables recycling |
| pythonService.sandbox.rlimitCPUSeconds | int | `60` | CPU-seconds backstop behind the wall-clock timeout |
| pythonService.sandbox.rlimitFSizeBytes | int | `64000000` | Largest file the child may write, in bytes |
| pythonService.sandbox.rlimitNProc | int | `512` | Per-UID process cap (must not starve numpy threads) |
| pythonService.sandbox.rlimitNoFile | int | `256` | Open file descriptor cap |
| pythonService.service.port | int | `8080` |  |
| pythonService.service.type | string | `"ClusterIP"` |  |
| pythonService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| pythonService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| pythonService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| pythonService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| pythonService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| pythonService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| queue | object | `{"annotations":{},"auditExportQueueName":"audit-export-runs","auditQueueName":"ragnerock-audit","autoscaling":{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80},"callbackQueueName":"ragnerock-callbacks","jobQueueName":"ragnerock-document-jobs","maxConcurrentDispatches":500,"maxDispatchesPerSecond":500,"port":8123,"queuePoolSize":100,"resources":{},"serviceAccount":{"annotations":{},"create":false,"name":""},"subtaskQueueName":"ragnerock-subtask-jobs","tolerations":[],"volumeMounts":[],"volumes":[]}` | Cloudtask configuration for use with in-cluster emulator |
| queue.annotations | object | `{}` | Annotations added to the queue deployment's metadata (merged with `global.annotations`; per-service keys take precedence) |
| queue.auditExportQueueName | string | `"audit-export-runs"` | Queue the audit-service enqueues its own /audit/export-run tasks onto |
| queue.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| queue.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| queue.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| queue.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| queue.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| queue.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| queue.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| queue.tolerations | list | `[]` | Pod tolerations for the queue deployment (overrides `global.tolerations`) |
| queue.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| queue.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| ragnerock.safetyEnabled | bool | `true` | Should Ragnerock treat all prompts as unsafe |
| rateLimits.adminMutationPerMinute | int | `40` |  |
| rateLimits.agentPerMinute | int | `20` |  |
| rateLimits.annotationPerMinute | int | `120` |  |
| rateLimits.apiTokenPerMinute | int | `30` |  |
| rateLimits.auditPayloadPerMinute | int | `30` |  |
| rateLimits.authChangePasswordPerMinute | int | `5` |  |
| rateLimits.authGooglePerMinute | int | `15` |  |
| rateLimits.authLoginPerMinute | int | `15` |  |
| rateLimits.authRegisterPerMinute | int | `15` |  |
| rateLimits.authRequestCodePerMinute | int | `5` |  |
| rateLimits.authValidateCodePerMinute | int | `15` |  |
| rateLimits.chatCreatePerMinute | int | `600` |  |
| rateLimits.configValidatePerMinute | int | `20` |  |
| rateLimits.debugPerMinute | int | `20` |  |
| rateLimits.documentChunkCreatePerMinute | int | `600` |  |
| rateLimits.documentUploadPerMinute | int | `60` |  |
| rateLimits.frontendEventsPerMinute | int | `600` |  |
| rateLimits.iamMutationPerMinute | int | `60` |  |
| rateLimits.ingestTriggerPerMinute | int | `20` |  |
| rateLimits.notebookCodeFeedbackPerMinute | int | `40` |  |
| rateLimits.notificationStreamPerMinute | int | `10` |  |
| rateLimits.operatorTestPerMinute | int | `60` |  |
| rateLimits.queryAssistPerMinute | int | `30` |  |
| rateLimits.queryExecutePerMinute | int | `120` |  |
| rateLimits.queryValidatePerMinute | int | `60` |  |
| rateLimits.requestsPerMinute | int | `600` |  |
| rateLimits.searchPerMinute | int | `60` |  |
| rateLimits.toolsPerMinute | int | `60` |  |
| rateLimits.windowMinutes | int | `1` |  |
| rateLimits.workflowTestConditionPerMinute | int | `120` |  |
| subtaskWorker.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| subtaskWorker.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| subtaskWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| subtaskWorker.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| subtaskWorker.image.name | string | `"worker"` |  |
| subtaskWorker.image.tag | string | `""` |  |
| subtaskWorker.podDisruptionBudget | object | `{"enabled":false,"maxUnavailable":null,"minAvailable":1}` | Optional pod disruption budget, keeping capacity available during voluntary disruptions (node drains, cluster upgrades). Set exactly one of `minAvailable`/`maxUnavailable`; the other must be null. Both accept an integer or a percentage string (e.g. `"50%"`). |
| subtaskWorker.replicaCount | int | `1` |  |
| subtaskWorker.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| subtaskWorker.service.port | int | `8080` |  |
| subtaskWorker.service.type | string | `"ClusterIP"` |  |
| subtaskWorker.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| subtaskWorker.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| subtaskWorker.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| subtaskWorker.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| subtaskWorker.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| subtaskWorker.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| tools.codeToolTimeoutSeconds | int | `30` |  |
| worker.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| worker.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| worker.image.name | string | `"worker"` |  |
| worker.image.tag | string | `""` |  |
| worker.podDisruptionBudget | object | `{"enabled":false,"maxUnavailable":null,"minAvailable":1}` | Optional pod disruption budget, keeping capacity available during voluntary disruptions (node drains, cluster upgrades). Set exactly one of `minAvailable`/`maxUnavailable`; the other must be null. Both accept an integer or a percentage string (e.g. `"50%"`). |
| worker.replicaCount | int | `1` |  |
| worker.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| worker.service.port | int | `8080` |  |
| worker.service.type | string | `"ClusterIP"` |  |
| worker.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| worker.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| worker.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| worker.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| worker.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| worker.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
