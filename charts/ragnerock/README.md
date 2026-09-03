# ragnerock

![Version: 1.5.0](https://img.shields.io/badge/Version-1.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2026.08.28](https://img.shields.io/badge/AppVersion-v2026.08.28-informational?style=flat-square)

Ragnerock research intelligence platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agent.annotationToolMaxIterations | int | `25` | Tool-call iterations an annotation operator's agent may take before it is cut off |
| agent.cachedTokenWeight | float | `0.1` | Weight of a cache-read input token in the cost-weighted budget unit |
| agent.contextEvictionHighWaterTokens | string | `""` | In-turn context-eviction trigger (previous call's input tokens). Empty disables eviction; intended production value 140000 |
| agent.contextEvictionLowWaterTokens | int | `90000` | Context-eviction pass target, in tokens |
| agent.contextEvictionMinChars | int | `2000` | Smallest tool-result content (chars) worth stubbing during eviction |
| agent.drainToolCalls | bool | `false` | Rollout flag for parallel tool-call draining: when true the Runner executes the whole tool-call batch before re-invoking |
| agent.maxIterations | int | `10` |  |
| agent.reasoningEnabled | bool | `true` | Ops kill switch for reasoning/thinking: when false the API never sets a reasoning effort |
| agent.subAgentBudgetFraction | float | `0.5` | A sub-runner's spend ceiling as a share of the parent turn's remaining budget at spawn |
| agent.tokenBudgetSoftFraction | float | `0.8` | Soft advisory threshold: at this fraction of the turn budget the Runner injects one non-forcing wrap-up message |
| agent.toolResultImages | bool | `false` | Rollout flag: attach sandbox plots to tool results so the model sees them within the producing turn |
| agent.turnTokenBudget | int | `150000` | Turn token budget in cost-weighted units (output + uncached input + cachedTokenWeight x cached input). Empty disables budget termination, leaving the iteration cap as the only backstop |
| analysis.dataframeOpTimeout | int | `60` |  |
| analysis.maxColumns | int | `500` |  |
| analysis.maxRows | int | `50000` |  |
| analysis.modelFitTimeoutSeconds | int | `120` |  |
| analysis.plotDPI | int | `150` |  |
| analysis.plotMaxFigsize.dimx | float | `12` |  |
| analysis.plotMaxFigsize.dimy | float | `16` |  |
| analysis.plotTimeoutSeconds | int | `60` |  |
| analysisToolkit.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| api.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
| api.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| api.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| api.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| api.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| api.capacityWaitSeconds | float | `5` | Seconds a request waits for capacity before it is rejected |
| api.dbThreadpoolSize | int | `64` | Threads serving blocking DB work off the event loop |
| api.image.name | string | `"api"` |  |
| api.image.tag | string | `""` |  |
| api.maxConcurrentRequests | int | `128` | In-flight requests one API pod accepts before it starts shedding |
| api.operatorSample.maxFileBytes | int | `20971520` | Max workbench attachment size accepted by the parse-sample endpoint. The file rides to the worker as base64 JSON (~4/3 the size), so keep it at or below 20 MiB |
| api.operatorSample.parseTimeoutSeconds | int | `300` | API-side read timeout on the synchronous worker parse call, in seconds. Whole-document OCR of a large PDF via an external backend takes minutes |
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
| audit.imageMaxBytes | int | `716800` | Largest single stripped audit image (bytes) the emitter ships to the image sink |
| audit.imageQueueMaxBytes | int | `33554432` | Byte ceiling on the audit emitter's in-memory image queue |
| audit.imageStoreEnabled | bool | `false` | Rollout flag: ship stripped audit image bytes to audit-service for content-addressed blob storage |
| audit.kwargsSummaryMaxKeys | int | `50` |  |
| audit.listLimitCap | int | `200` |  |
| audit.payloadFieldMaxBytes | int | `204800` |  |
| audit.promptPreviewMaxChars | int | `500` |  |
| audit.queueMaxBytes | int | `134217728` |  |
| audit.queueMaxEvents | int | `10000` |  |
| audit.resnapshotTurns | int | `10` |  |
| auditService.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| callbackDelivery.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| dataIngestor.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| dbService.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
| dbService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| dbService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| dbService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| dbService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| dbService.batchLimit | int | `10000` |  |
| dbService.connectionFailureThreshold | int | `5` | Consecutive connection failures before a config is flagged for deactivation |
| dbService.defaultDBMaxOverflow | int | `20` | Overflow above the pool size for a customer database that does not specify one |
| dbService.defaultDBPoolSize | int | `20` | Connection pool size for a customer database that does not specify one |
| dbService.image.name | string | `"db-service"` |  |
| dbService.image.tag | string | `""` | Overwrites global value if set |
| dbService.rateLimitMaxTokens | int | `100` | Per-customer-DB rate limit: token bucket capacity (the default data DB is exempt) |
| dbService.rateLimitRefillRate | float | `20` | Per-customer-DB rate limit: token refill rate (tokens per second) |
| dbService.replicaCount | int | `1` |  |
| dbService.requestThreadpoolSize | int | `80` | Threads serving blocking driver work off the event loop |
| dbService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| dbService.service.port | int | `8080` |  |
| dbService.service.type | string | `"ClusterIP"` |  |
| dbService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| dbService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| dbService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| dbService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| dbService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| dbService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| decorators | object | `{"checkMaxAttempts":5,"checkTimeoutSeconds":30,"enabled":true,"judgeMaxRuns":5,"maxLeafCalls":30,"maxPerNode":4,"renderMaxChars":20000}` | Node decorators (JUDGE/CHECK/CRITIC/TOKEN_BUDGET): the global kill switch and the bounds that keep a decorated node's per-item cost bounded. |
| decorators.checkMaxAttempts | int | `5` | Upper bound on a check/critic's retry attempts |
| decorators.checkTimeoutSeconds | int | `30` | python-service timeout for a check's code, in seconds |
| decorators.enabled | bool | `true` | Serve node decorators. Set to false to reject decorator writes and fail decorated items rather than silently running the bare operator. |
| decorators.judgeMaxRuns | int | `5` | Upper bound on a judge's runs |
| decorators.maxLeafCalls | int | `30` | Ceiling on base-operator calls one decorated invocation may make |
| decorators.maxPerNode | int | `4` | Decorator specs allowed on a single node |
| decorators.renderMaxChars | int | `20000` | Ceiling on a rendered judge candidate / critic output, in characters |
| encryption.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENCRYPTION_KEK`) instead of generating one. When set, `kek` is ignored. |
| encryption.kek | string | `""` | Key Encryption Key (KEK), generate with python -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())' |
| endpoints.HMACMasterKey | string | `""` |  |
| endpoints.allowPrivateCallbacks | bool | `true` |  |
| endpoints.compatMaxBodyBytes | int | `10485760` | Request body ceiling for the OpenAI/Anthropic/Gemini-compatible endpoints, in bytes |
| endpoints.compatTimeoutSeconds | int | `300` | Wall-clock ceiling for one compatibility-endpoint call, in seconds |
| endpoints.ephemeralTTLHours | int | `24` |  |
| endpoints.executionPruneBatchSize | int | `5000` | Execution records deleted per prune statement |
| endpoints.executionPruneMaxBatches | int | `100` | Prune statements issued in one pass before the job yields |
| endpoints.executionRetentionDays | int | `90` | Days an endpoint execution record is kept before it is pruned |
| endpoints.existingSecret | string | `""` | Use a pre-existing secret (must provide key `ENDPOINTS_HMAC_MASTER_KEY`) instead of generating one. When set, `HMACMasterKey` is ignored. |
| endpoints.maxFileSizeMB | int | `50` |  |
| fallback | object | `{"agentChainBudgetSeconds":120,"chainBudgetSeconds":420,"maxChainCiphertextBytes":30720,"maxDepth":3,"perProviderAttempts":2}` | BYOAI fallback chains: how far a chain may reach and how long the model-service will spend working through one. |
| fallback.agentChainBudgetSeconds | int | `120` | Wall-clock budget for one agent chain, in seconds |
| fallback.chainBudgetSeconds | int | `420` | Wall-clock budget for one annotation chain, in seconds |
| fallback.maxChainCiphertextBytes | int | `30720` | Ceiling on the summed ciphertext of a chain's fallback leaves, in bytes |
| fallback.maxDepth | int | `3` | Fallback hops allowed after the primary provider |
| fallback.perProviderAttempts | int | `2` | Attempts against each provider in a chain before moving to the next |
| frontend.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| gitops.codeReviewBudgetSeconds | int | `60` | Wall-clock budget for the code security review that runs after a GitOps apply, in seconds. Agents not reached in time are reported unreviewed. |
| gitops.existingSecret | string | `""` | Use a pre-existing secret (must provide key `GITOPS_SEALING_PRIVATE_KEY`) instead of generating one. When set, `sealingPrivateKey` is ignored. |
| gitops.maxManifestBytes | int | `5242880` | Largest manifest `POST /api/gitops/apply` accepts, in bytes |
| gitops.sealingPrivateKey | string | `""` | RSA private key (PEM) that opens GitOps secrets the GitHub action sealed for transport, generate with `task gitops-sealing-key`. Leave empty to run without transport sealing; the action then fails rather than uploading plaintext. |
| global.affinity | object | `{}` | Default pod affinity rules applied to all workloads. Can be overridden per-service with `<service>.affinity`. See https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
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
| licenseCheck.enabled | bool | `true` | Enable license enforcement. Turning this off skips both the startup check and the periodic re-check; intended for air-gapped evaluation, not for production. |
| licenseCheck.graceSeconds | int | `259200` | How long a service may keep serving without a successful validation before it stops (default: 3 days) |
| licenseCheck.intervalSeconds | int | `86400` | Seconds between checks after a successful validation (default: once a day) |
| licenseCheck.retrySeconds | int | `3600` | Seconds between checks while the license server is unreachable |
| licenseCheck.shutdownGraceSeconds | int | `30` | Seconds allowed for graceful shutdown after a lapsed license before the process is killed |
| licenseCheck.timeoutSeconds | int | `10` | Per-request timeout for one validation call, in seconds |
| licenseExistingSecret | string | `""` | Use a pre-existing secret (must provide key `RAGNEROCK_LICENSE`) instead of generating one. When set, `license` is ignored. |
| licenseServerUrl | string | `"https://licenses.ragnerock.com"` | License server the deployment validates against |
| limits.batches.annotation | int | `50` |  |
| limits.batches.defaultRow | int | `50` |  |
| limits.batches.embedding | int | `100` |  |
| limits.batches.tabularAnnotation | int | `200` |  |
| limits.codeOperator.timeoutSeconds | int | `30` | Wall-clock ceiling for a code operator's execution, in seconds |
| limits.concurrency.maxConcurrentAnnotations | int | `10` |  |
| limits.concurrency.maxConcurrentJobs | int | `10` |  |
| limits.concurrency.maxConcurrentSampleParses | int | `2` | Concurrent workbench attachment parses one worker pod accepts. These are synchronous API-originated calls sharing the pod with queue deliveries, so the pool is small; excess requests shed as 503 |
| limits.concurrency.maxConcurrentSubtasks | int | `50` |  |
| limits.job.watchdogSlackMinutes | int | `5` | Extra delay past the subtask stale threshold before the job watchdog reconciles |
| limits.subtask.failureThreshold | float | `0.05` |  |
| limits.subtask.maxAttempts | int | `3` |  |
| limits.subtask.staleThresholdMinutes | int | `35` | Minutes without a heartbeat before an in-flight subtask may be re-claimed |
| limits.usage.maxComputeSeconds | string | `"86400"` |  |
| limits.usage.maxInputTokens | string | `"1000000"` |  |
| limits.usage.maxOutputTokens | string | `"1000000"` |  |
| limits.usage.maxPages | string | `"2000"` |  |
| liveLog | object | `{"allowUnscoped":false,"buffer":{"maxAgeSeconds":900,"maxRows":100000,"tailCacheSeconds":2,"trimIntervalSeconds":10},"enabled":true,"shipper":{"backpressureLogSeconds":60,"batchMaxRecords":500,"drainTimeoutSeconds":3,"flushSeconds":1,"idlePollSchedule":[{"after_idle_seconds":0,"interval_seconds":3},{"after_idle_seconds":120,"interval_seconds":15},{"after_idle_seconds":600,"interval_seconds":30}],"maxExceptionBytes":16384,"queueMaxRecords":10000,"requestTimeoutSeconds":5},"tail":{"clientMaxRecords":100,"leaseSeconds":60,"snapshotLines":500,"streamHeartbeatSeconds":20,"streamPageSize":500,"streamPollSeconds":1}}` | Live log tail (docs/design-docs/live-logs.md). Services ship their log records to audit-service, which buffers them for the Live Logs admin view. |
| liveLog.allowUnscoped | bool | `false` | Allow admins to tail every account's log lines, not just their own. Correct for a single-tenant install; must stay false anywhere several tenants share the deployment, where it would expose one tenant's logs to another. |
| liveLog.buffer.maxAgeSeconds | int | `900` | Age cap on the buffer table, applied alongside the row cap. Dominates when the system is quiet. |
| liveLog.buffer.maxRows | int | `100000` | Row cap on the buffer table. Sized to cover a client's reconnect gap, not to hold history; dominates under load. |
| liveLog.buffer.tailCacheSeconds | float | `2` | Seconds audit-service caches the answer to "is a tail open?" before re-reading the lease table. Every ingest batch asks, so this bounds that read rate. |
| liveLog.buffer.trimIntervalSeconds | float | `10` | Minimum gap between trims in one writer process. The bounds hold approximately; trimming per write has every writer deleting from the same hot range under its insert locks. |
| liveLog.enabled | bool | `true` | Serve the live log tail. On by default: a self-hosted install is the case this feature is for. Shipping is demand-gated on top of this, so services send nothing until an operator opens the tail. Turn it off in a shared environment, where the tail is our operational surface and not the tenant's. |
| liveLog.shipper | object | `{"backpressureLogSeconds":60,"batchMaxRecords":500,"drainTimeoutSeconds":3,"flushSeconds":1,"idlePollSchedule":[{"after_idle_seconds":0,"interval_seconds":3},{"after_idle_seconds":120,"interval_seconds":15},{"after_idle_seconds":600,"interval_seconds":30}],"maxExceptionBytes":16384,"queueMaxRecords":10000,"requestTimeoutSeconds":5}` | Pacing and bounds for the in-process shipper every service runs. It drops rather than blocks, so these govern how much it may hold and how long it may wait. |
| liveLog.shipper.backpressureLogSeconds | float | `60` | Minimum gap between a shipper's reports of records it lost, so the loss can be alerted on rather than only counted in-process |
| liveLog.shipper.batchMaxRecords | int | `500` | Records the shipper sends to audit-service in one batch |
| liveLog.shipper.drainTimeoutSeconds | float | `3` | Shutdown drain budget for the shipper, in seconds |
| liveLog.shipper.flushSeconds | float | `1` | Seconds a record waits in the queue before a batch is sent |
| liveLog.shipper.idlePollSchedule | list | `[{"after_idle_seconds":0,"interval_seconds":3},{"after_idle_seconds":120,"interval_seconds":15},{"after_idle_seconds":600,"interval_seconds":30}]` | Decaying idle heartbeat: how often the shipper polls for tail demand, stepping to the last tier whose idle threshold has been reached. Tiers must be in ascending threshold order. |
| liveLog.shipper.maxExceptionBytes | int | `16384` | Tracebacks longer than this are truncated, and flagged on the record |
| liveLog.shipper.queueMaxRecords | int | `10000` | Count-only bound on each service's shipper queue; oldest records are evicted first, which is what a tail wants |
| liveLog.shipper.requestTimeoutSeconds | float | `5` | Timeout on the shipper's call to audit-service. Kept short: a shipper that blocks is worse than one that drops. |
| liveLog.tail | object | `{"clientMaxRecords":100,"leaseSeconds":60,"snapshotLines":500,"streamHeartbeatSeconds":20,"streamPageSize":500,"streamPollSeconds":1}` | The API's tail read path: lease renewal, opening snapshot, poll pacing, and the tighter caps on the untrusted browser relay. |
| liveLog.tail.clientMaxRecords | int | `100` | Maximum records accepted per browser-forwarded log batch. Browser input is untrusted, so this is capped tighter than anything on the service side. |
| liveLog.tail.leaseSeconds | int | `60` | Seconds a poll cycle of an open tail extends the shipping lease. Services ship only while an unexpired lease exists, so this also bounds how long shipping outlives a crashed API pod. |
| liveLog.tail.snapshotLines | int | `500` | Lines sent when a tail opens. Sized for time-to-first-paint, not history. |
| liveLog.tail.streamHeartbeatSeconds | float | `20` | Idle seconds after which the tail sends an SSE keepalive comment |
| liveLog.tail.streamPageSize | int | `500` | Maximum lines a single tail poll returns |
| liveLog.tail.streamPollSeconds | float | `1` | Seconds between an open tail's polls for new lines |
| llm | object | `{"azure":{"apiKey":"","endpoint":""},"existingSecret":"","gemini":{"apiKey":""},"mistral":{"apiKey":"","retry":{"exponent":2,"initialIntervalMS":1000,"maxElapsedMS":600000,"maxIntervalMS":60000}},"pdfExtractImages":true,"pdfParserBackend":"mistral","textract":{"accessKeyId":"","existingSecret":"","maxConcurrency":4,"region":"","secretAccessKey":""}}` | LLM authentication configuration |
| llm.existingSecret | string | `""` | Use a pre-existing secret (must provide keys `GEMINI_API_KEY` and `MISTRAL_API_KEY`) instead of generating one. When set, `geminiApiKey`/`mistralApiKey` are ignored. |
| llm.mistral.retry | object | `{"exponent":2,"initialIntervalMS":1000,"maxElapsedMS":600000,"maxIntervalMS":60000}` | Retry policy for the Mistral OCR call. The SDK does not retry unless it is handed a config, so without these a single 429 or 5xx from the OCR endpoint fails the whole document job. Intervals are in milliseconds, the unit the SDK's backoff strategy takes. |
| llm.mistral.retry.exponent | float | `2` | Growth factor applied to the backoff after each attempt |
| llm.mistral.retry.initialIntervalMS | int | `1000` | First backoff interval before the OCR call is retried |
| llm.mistral.retry.maxElapsedMS | int | `600000` | Total retry budget for one OCR call, matching the Document AI backend's 10-minute deadline |
| llm.mistral.retry.maxIntervalMS | int | `60000` | Ceiling on the backoff interval. A `Retry-After` header on the response wins over the computed backoff. |
| llm.pdfExtractImages | bool | `true` | Extract embedded images from PDFs during parsing (for multimodal summarization) |
| llm.pdfParserBackend | string | `"mistral"` | PDF parsing backend: `mistral`, `azure`, or `textract` |
| llm.textract.accessKeyId | string | `""` | AWS access key ID. Required when `pdfParserBackend` is `textract`. |
| llm.textract.existingSecret | string | `""` | Use a pre-existing secret (must provide key `AWS_SECRET_ACCESS_KEY`) instead of generating one. When set, `secretAccessKey` is ignored. |
| llm.textract.maxConcurrency | int | `4` | Maximum concurrent Textract page requests per worker |
| llm.textract.region | string | `""` | AWS region the Textract API is called in. Required when `pdfParserBackend` is `textract`. |
| llm.textract.secretAccessKey | string | `""` | AWS secret access key. Required when `pdfParserBackend` is `textract`. |
| memory | object | `{"schemaHardCap":100,"schemaSoftCap":25,"toolsEnabled":true,"writeBudgetAnnotation":12,"writeBudgetNotebook":8}` | Agentic memory: the ops kill switch, schema-proliferation caps, and the per-run write budgets that bound a single agent's memory writes. |
| memory.schemaHardCap | int | `100` | Schemas per project past which creating another is refused |
| memory.schemaSoftCap | int | `25` | Schemas per project past which creating another is discouraged |
| memory.toolsEnabled | bool | `true` | Expose the memory tools to agents. Set to false to switch memory off entirely. |
| memory.writeBudgetAnnotation | int | `12` | Memory writes allowed in a single annotation run |
| memory.writeBudgetNotebook | int | `8` | Memory writes allowed in a single notebook turn |
| migrations.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
| migrations.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| migrations.image.name | string | `"migrations"` |  |
| migrations.image.tag | string | `""` |  |
| migrations.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| migrations.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| migrations.serviceAccount.create | bool | `false` | Create a service account for the migrations job's pods |
| migrations.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| migrations.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| model.agentNoChainMaxAttempts | int | `4` | Agent attempts when no fallback chain is configured |
| model.annotatorNoChainMaxAttempts | int | `8` | Annotator attempts when no fallback chain is configured |
| model.annotatorRetryBudgetSeconds | int | `420` | Wall-clock budget for annotator retries, in seconds |
| model.anthropicMaxOutputTokens | int | `8192` | Anthropic response-length ceiling (tokens); with thinking, max_tokens = thinking budget + this |
| model.anthropicThinkingBudgetHigh | int | `16384` | Anthropic thinking token budget for the HIGH effort tier |
| model.anthropicThinkingBudgetLow | int | `4096` | Anthropic thinking token budget for the LOW effort tier |
| model.anthropicThinkingBudgetMedium | int | `8192` | Anthropic thinking token budget for the MEDIUM effort tier |
| model.geminiMaxOutputTokens | int | `16384` | Output-token ceiling for the default Gemini provider |
| model.geminiModelName | string | `"gemini-3-flash-preview"` |  |
| model.geminiThinkingBudgetHigh | int | `24576` | Gemini thinking token budget for the HIGH effort tier |
| model.geminiThinkingBudgetLow | int | `1024` | Gemini thinking token budget for the LOW effort tier |
| model.geminiThinkingBudgetMedium | int | `8192` | Gemini thinking token budget for the MEDIUM effort tier |
| model.geminiThinkingLevel | string | `"LOW"` | Gemini thinking budget: `LOW`, `MEDIUM`, or `HIGH` |
| model.geminiTruncationRetries | int | `1` | Retries when a Gemini response comes back truncated |
| model.httpTimeoutSeconds | int | `180` |  |
| model.maxConcurrentProviderCalls | int | `50` | Provider calls the model-service will have in flight at once |
| model.openaiUseResponsesApi | bool | `false` | Route OpenAI calls through the Responses API (enables encrypted reasoning items) |
| modelService.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| notebook | object | `{"auditTurnSnapshot":false,"compactionTimeoutSeconds":120,"sandboxCodeCells":false}` | Notebook agent rollout flags and the compaction-call timeout. |
| notebook.auditTurnSnapshot | bool | `false` | Rollout flag: capture a full history snapshot on the first iteration of every notebook turn so the audit record is exactly replayable |
| notebook.compactionTimeoutSeconds | int | `120` | Wall-clock bound (seconds) on the one-shot notebook-compaction summarization call |
| notebook.sandboxCodeCells | bool | `false` | Rollout flag: persist a real CODE cell for each sandbox execution so the UI and next turn's history see sandbox runs like kernel runs |
| otel | object | `{"authHeader":"","enabled":false,"existingSecret":"","exporterEndpoint":"","exporterInsecure":false,"exporterProtocol":"http/protobuf","serviceNamespace":"ragnerock","servicePrefix":""}` | Otel metrics/traces/logs export |
| otel.existingSecret | string | `""` | Use a pre-existing secret (must provide key `OTEL_EXPORTER_OTLP_HEADERS`) instead of generating one. When set, `authHeader` is ignored. |
| otel.serviceNamespace | string | `"ragnerock"` | OTEL service namespace |
| otel.servicePrefix | string | `""` | Optional prefix for otel service names. E.g., setting servicePrefix to `foobar` changes api -> foobarapi |
| python | object | `{"batchChunkItems":16,"maxAttempts":4,"maxRequestBytes":48000000,"timeoutMarginSeconds":60}` | Client-side knobs used by callers of python-service (API and workers). The sandbox's own configuration lives under `pythonService.sandbox`. |
| python.batchChunkItems | int | `16` | Items per chunk when a batch execution is split across requests |
| python.maxAttempts | int | `4` | Attempts per execution request before giving up |
| python.maxRequestBytes | int | `48000000` | Request payload ceiling enforced before send, in bytes |
| python.timeoutMarginSeconds | float | `60` | Seconds added to the execution budget to form the HTTP read timeout |
| pythonService.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| queue | object | `{"affinity":{},"annotations":{},"auditExportQueueName":"audit-export-runs","auditQueueName":"ragnerock-audit","autoscaling":{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80},"callbackQueueName":"ragnerock-callbacks","jobQueueName":"ragnerock-document-jobs","maxConcurrentDispatches":500,"maxDispatchesPerSecond":500,"port":8123,"queuePoolSize":100,"resources":{},"serviceAccount":{"annotations":{},"create":false,"name":""},"subtaskQueueName":"ragnerock-subtask-jobs","tolerations":[],"volumeMounts":[],"volumes":[]}` | Cloudtask configuration for use with in-cluster emulator |
| queue.affinity | object | `{}` | Pod affinity rules for the queue deployment (overrides `global.affinity`) |
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
| rateLimits.backfillRunPerMinute | int | `30` |  |
| rateLimits.chatCreatePerMinute | int | `600` |  |
| rateLimits.configValidatePerMinute | int | `20` |  |
| rateLimits.debugPerMinute | int | `20` |  |
| rateLimits.documentChunkCreatePerMinute | int | `600` |  |
| rateLimits.documentUploadPerMinute | int | `60` |  |
| rateLimits.frontendEventsPerMinute | int | `600` |  |
| rateLimits.iamMutationPerMinute | int | `60` |  |
| rateLimits.ingestTriggerPerMinute | int | `20` |  |
| rateLimits.liveLogClientPerMinute | int | `30` | Per-user limit on the browser log relay endpoint |
| rateLimits.liveLogStreamPerMinute | int | `10` | Per-user limit on opening the live-log tail |
| rateLimits.notebookCodeFeedbackPerMinute | int | `40` |  |
| rateLimits.notebookCompactionPerMinute | int | `10` |  |
| rateLimits.notificationStreamPerMinute | int | `10` |  |
| rateLimits.operatorParseSamplePerMinute | int | `10` | Per-user limit on workbench attachment parses. Each request can hold a synchronous worker OCR call for minutes, so the ceiling is deliberately low |
| rateLimits.operatorTestPerMinute | int | `60` |  |
| rateLimits.queryAssistPerMinute | int | `30` |  |
| rateLimits.queryExecutePerMinute | int | `120` |  |
| rateLimits.queryValidatePerMinute | int | `60` |  |
| rateLimits.requestsPerMinute | int | `600` |  |
| rateLimits.searchPerMinute | int | `60` |  |
| rateLimits.toolsPerMinute | int | `60` |  |
| rateLimits.windowMinutes | int | `1` |  |
| rateLimits.workflowTestConditionPerMinute | int | `120` |  |
| skills | object | `{"bodyMaxChars":32000,"descriptionMaxChars":512,"enabled":true,"loadMaxCalls":10,"maxPerOperator":10}` | Agent skills: the ops kill switch, the size caps that bound catalog and body token cost, and the per-run load budget. |
| skills.bodyMaxChars | int | `32000` | Maximum instruction-body length in characters |
| skills.descriptionMaxChars | int | `512` | Maximum description length in characters (bounds catalog token cost) |
| skills.enabled | bool | `true` | Serve skills to agents. Set to false to switch skills off entirely. |
| skills.loadMaxCalls | int | `10` | load_skill calls allowed in a single run |
| skills.maxPerOperator | int | `10` | Skills a single workflow agent may select |
| subtaskWorker.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| tabular | object | `{"listPageSize":20,"promptMaxColumns":20,"promptMaxSources":10,"readRowsPerPage":50}` | Tabular documents: page sizes for reads and the shape of the table summaries rendered into prompts. |
| tabular.listPageSize | int | `20` | Rows returned per page when an agent lists a tabular document |
| tabular.promptMaxColumns | int | `20` | Columns of a table described in a prompt |
| tabular.promptMaxSources | int | `10` | Tables described in a single prompt |
| tabular.readRowsPerPage | int | `50` | Rows returned per page when an agent reads a tabular document |
| tools.codeToolTimeoutSeconds | int | `30` |  |
| tools.maxResultImages | int | `10` | Cap on images attached to a single agent tool result |
| worker.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
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
| workers | object | `{"capacityWaitSeconds":5,"database":{"lockTimeoutSeconds":30,"maxOverflow":null,"poolHeadroom":5,"poolSize":null,"poolTimeout":10},"dbThreadpoolSize":80,"maxChunkChars":6000,"maxConcurrentJobAdvances":10,"reconcile":{"batchSize":100,"enabled":true,"inProgressAfterSeconds":2700,"intervalSeconds":300,"notStartedAfterSeconds":900}}` | Settings shared by the worker and subtask-worker deployments. Both run the same job-processing code, so they are tuned together. |
| workers.capacityWaitSeconds | float | `5` | Seconds a task waits for local capacity before it is deferred |
| workers.database.lockTimeoutSeconds | int | `30` | Seconds a statement waits on a row lock before erroring |
| workers.database.maxOverflow | string | `nil` | Explicit overflow above the pool size. Falls back to `poolHeadroom` when null. |
| workers.database.poolHeadroom | int | `5` | Connections kept spare on top of the derived pool size, for non-request work |
| workers.database.poolSize | string | `nil` | Explicit connection pool size. Derived from the concurrency limits plus `poolHeadroom` when null, mirroring the worker's own in-process derivation. |
| workers.database.poolTimeout | int | `10` | Seconds a checkout waits for a free pooled connection |
| workers.dbThreadpoolSize | int | `80` | Threads serving blocking DB work off the event loop |
| workers.maxChunkChars | int | `6000` | Characters per chunk when a document is split for embedding |
| workers.maxConcurrentJobAdvances | int | `10` | Concurrent job phase-advances a worker process may run |
| workers.reconcile | object | `{"batchSize":100,"enabled":true,"inProgressAfterSeconds":2700,"intervalSeconds":300,"notStartedAfterSeconds":900}` | Periodic DB sweep that re-enqueues jobs whose queue deliveries were dropped after exhausting their retry budget. |
| workers.reconcile.batchSize | int | `100` | Jobs examined per sweep |
| workers.reconcile.enabled | bool | `true` | Run the reconciliation sweep |
| workers.reconcile.inProgressAfterSeconds | int | `2700` | Seconds a job may sit in progress before the sweep re-enqueues it |
| workers.reconcile.intervalSeconds | int | `300` | Seconds between sweeps |
| workers.reconcile.notStartedAfterSeconds | int | `900` | Seconds a job may sit unstarted before the sweep re-enqueues it |
| workflowResources | object | `{"codeMaxBytes":20000000,"codeMaxRows":100000,"codeTotalMaxBytes":40000000,"contextMaxChars":200000,"valueMaxBytes":262144}` | Workflow resources bound into operator runs and rendered into prompts. |
| workflowResources.codeMaxBytes | int | `20000000` | Ceiling on a single code operator's returned resource, in bytes |
| workflowResources.codeMaxRows | int | `100000` | Ceiling on the rows a single code operator may return |
| workflowResources.codeTotalMaxBytes | int | `40000000` | Ceiling on all code operator resources for one run, in bytes |
| workflowResources.contextMaxChars | int | `200000` | Ceiling on the resource context rendered into one prompt, in characters |
| workflowResources.valueMaxBytes | int | `262144` | Ceiling on a value resource's serialized inline value, in bytes |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
