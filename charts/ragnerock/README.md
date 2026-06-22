# ragnerock

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Ragnerock research intelligence platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| analysis.dataframeOpTimeout | int | `60` |  |
| analysis.maxColumns | int | `500` |  |
| analysis.maxRows | int | `50000` |  |
| analysis.modelFitTimeoutSeconds | int | `120` |  |
| analysis.plotDPI | int | `150` |  |
| analysis.plotMaxFigsize.dimx | float | `12` |  |
| analysis.plotMaxFigsize.dimy | float | `16` |  |
| analysis.plotTimeoutSeconds | int | `60` |  |
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
| api.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| api.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| api.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| api.fqdn | string | `""` |  |
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
| api.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| api.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| auth.accessCodeExpireMinutes | int | `10080` |  |
| auth.accessKey | string | `""` | Generate with `openssl rand -hex 22` |
| auth.accessTokenExpireMinutes | int | `10080` |  |
| auth.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `SECRET_KEY` and `ACCESS_KEY`) instead of generating one. When set, `secretKey`/`accessKey` are ignored. |
| auth.lockoutMaxAttempts | int | `10` |  |
| auth.secretKey | string | `""` | Generate with `openssl rand -hex 22` |
| callbackDelivery.fqdn | string | `""` |  |
| callbackDelivery.image.name | string | `"api"` |  |
| callbackDelivery.image.tag | string | `""` |  |
| callbackDelivery.replicaCount | int | `1` |  |
| callbackDelivery.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| callbackDelivery.service.port | int | `8080` |  |
| callbackDelivery.service.type | string | `"ClusterIP"` |  |
| callbackDelivery.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| cloudflare.accountId | string | `""` |  |
| cloudflare.apiToken | string | `""` |  |
| cloudflare.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`) instead of generating one. When set, `apiToken`/`accountId` are ignored. |
| config | object | `{"environmentIdentifier":"ragnerock","logLevel":"INFO"}` | General app configuration |
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
| encryption.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENCRYPTION_KEK`) instead of generating one. When set, `kek` is ignored. |
| encryption.kek | string | `""` | Key Encryption Key (KEK), generate with python -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())' |
| endpoints.HMACMasterKey | string | `""` |  |
| endpoints.allowPrivateCallbacks | bool | `true` |  |
| endpoints.ephemeralTTLHours | int | `24` |  |
| endpoints.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENDPOINTS_HMAC_MASTER_KEY`) instead of generating one. When set, `HMACMasterKey` is ignored. |
| endpoints.maxFileSizeMB | int | `50` |  |
| frontend.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| frontend.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| frontend.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| frontend.fqdn | string | `""` |  |
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
| frontend.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| frontend.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| fullnameOverride | string | `nil` |  |
| global.image | object | `{"pullPolicy":"IfNotPresent","registry":"us-central1-docker.pkg.dev/ragnerock-prod/ragnerock","tag":"latest"}` | Global container image configuration |
| global.imagePullSecrets | list | `[]` | Secrets use to authenticate with the container registry, list of `- name: <name of the secret>` values |
| global.tolerations | list | `[]` | Default pod tolerations applied to all workloads. Can be overridden per-service with `<service>.tolerations`. See https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| ingest.staleTimeoutSeconds | int | `3600` |  |
| license | string | `""` | Ragnerock provided license key |
| licenseExistingSecret | string | `""` | Use a pre-existing secret (must provide key `RAGNEROCK_LICENSE`) instead of generating one. When set, `license` is ignored. |
| limits.batches.annotation | int | `50` |  |
| limits.batches.defaultRow | int | `50` |  |
| limits.batches.embedding | int | `100` |  |
| limits.batches.tabularAnnotation | int | `200` |  |
| limits.concurrency.maxConcurrentAnnotations | int | `10` |  |
| limits.concurrency.maxConcurrentJobs | int | `10` |  |
| limits.concurrency.maxConcurrentSubtasks | int | `50` |  |
| limits.subtask.failureThreshold | float | `0.05` |  |
| limits.subtask.maxAttempts | int | `3` |  |
| limits.usage.maxComputeSeconds | string | `"86400"` |  |
| limits.usage.maxInputTokens | string | `"1000000"` |  |
| limits.usage.maxOutputTokens | string | `"1000000"` |  |
| limits.usage.maxPages | string | `"2000"` |  |
| llm | object | `{"existingSecret":"","geminiApiKey":"","mistralApiKey":""}` | LLM authentication configuration |
| llm.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `GEMINI_API_KEY` and `MISTRAL_API_KEY`) instead of generating one. When set, `geminiApiKey`/`mistralApiKey` are ignored. |
| migrations.image.name | string | `"migrations"` |  |
| migrations.image.tag | string | `""` |  |
| migrations.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| migrations.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| migrations.serviceAccount.create | bool | `false` | Create a service account for the migrations job's pods |
| migrations.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| migrations.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| model.geminiModelName | string | `"gemini-3-flash-preview"` |  |
| model.httpTimeoutSeconds | int | `180` |  |
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
| queue | object | `{"callbackQueueName":"ragnerock-callbacks","jobQueueName":"ragnerock-document-jobs","maxConcurrentDispatches":500,"maxDispatchesPerSecond":500,"port":8123,"queuePoolSize":100,"serviceAccount":{"annotations":{},"create":false,"name":""},"subtaskQueueName":"ragnerock-subtask-jobs","tolerations":[]}` | Cloudtask configuration for use with in-cluster emulator |
| queue.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| queue.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| queue.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| queue.tolerations | list | `[]` | Pod tolerations for the queue deployment (overrides `global.tolerations`) |
| ragnerock.safetyEnabled | bool | `true` | Should Ragnerock treat all prompts as unsafe |
| rateLimits.adminMutationPerMinute | int | `40` |  |
| rateLimits.agentPerMinute | int | `20` |  |
| rateLimits.annotationPerMinute | int | `120` |  |
| rateLimits.apiTokenPerMinute | int | `30` |  |
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
| rateLimits.queryAssistPerMinute | int | `30` |  |
| rateLimits.queryExecutePerMinute | int | `120` |  |
| rateLimits.queryValidatePerMinute | int | `60` |  |
| rateLimits.requestsPerMinute | int | `600` |  |
| rateLimits.searchPerMinute | int | `60` |  |
| rateLimits.toolsPerMinute | int | `60` |  |
| rateLimits.windowMinutes | int | `1` |  |
| rateLimits.workflowTestConditionPerMinute | int | `120` |  |
| subtaskWorker.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| subtaskWorker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| subtaskWorker.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| subtaskWorker.image.name | string | `"worker"` |  |
| subtaskWorker.image.tag | string | `""` |  |
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
| worker.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| worker.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| worker.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| worker.image.name | string | `"worker"` |  |
| worker.image.tag | string | `""` |  |
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
