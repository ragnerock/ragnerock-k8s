# ragnerock

![Version: 1.7.0](https://img.shields.io/badge/Version-1.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2026.09.22-2](https://img.shields.io/badge/AppVersion-v2026.09.22--2-informational?style=flat-square)

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
| agentTools | object | `{"annotationQueueWaitSeconds":120,"annotationToolCallRecordResultMaxChars":40000,"auditResultMaxChars":8000,"buildTimeBudgetSeconds":600,"busyWaitSeconds":5,"callTimeoutMaxSeconds":120,"callTimeoutSeconds":30,"connectTimeoutSeconds":5,"descriptionMaxChars":1024,"discoveryTimeoutSeconds":20,"enabled":true,"executionLogEnabled":true,"executionLogWriteTimeoutSeconds":5,"headerValueMaxChars":4096,"maxCallsPerInvocation":10,"maxConcurrentCalls":20,"maxFunctionsPerAgent":40,"maxHeaders":20,"maxPerOperator":10,"maxResultImages":4,"maxUserToolsPerProject":25,"mcpMaxFunctions":30,"oauthClientMetadataCacheSeconds":3600,"oauthEnabled":true,"oauthFlowTtlSeconds":600,"oauthMetadataMaxBytes":65536,"oauthRefreshLeaseSeconds":30,"oauthRefreshSkewSeconds":60,"oauthStartDeadlineSeconds":30,"oauthTokenRequestTimeoutSeconds":10,"paramDescriptionMaxChars":256,"privateEgressAllowlist":"","requestBodyMaxBytes":262144,"responseMaxBytes":262144,"restMaxRoutes":30,"resultMaxChars":32000,"rowTimeBudgetSeconds":360,"schemaMaxBytes":16384,"schemaMaxDepth":5}` | Agent tools: the ops kill switch plus the size, time, and concurrency bounds for the MCP servers and REST APIs a project points its agents at. |
| agentTools.annotationQueueWaitSeconds | int | `120` | How long an annotation call waits for the same semaphores. A refused call there is a failed row, so it queues; a row that still starves past this is classified retryable and costs a redelivery |
| agentTools.annotationToolCallRecordResultMaxChars | int | `40000` | Cap on a stored annotation tool-call result (provenance, not replay) |
| agentTools.auditResultMaxChars | int | `8000` | Cap on the result text carried in an external-tool audit payload |
| agentTools.buildTimeBudgetSeconds | int | `600` | Total tool wall clock per subtask or notebook turn |
| agentTools.busyWaitSeconds | int | `5` | How long a notebook call waits for a concurrency semaphore before failing in-band; a person is waiting on that path |
| agentTools.callTimeoutMaxSeconds | int | `120` | Cap on a per-route or per-server timeout override |
| agentTools.callTimeoutSeconds | int | `30` | Per-call wall clock when the route or server sets none |
| agentTools.connectTimeoutSeconds | int | `5` | Connect timeout, so unreachable hosts fail fast |
| agentTools.descriptionMaxChars | int | `1024` | Maximum function description length (it rides every prompt) |
| agentTools.discoveryTimeoutSeconds | int | `20` | Timeout for an MCP tools/list call at save or refresh |
| agentTools.enabled | bool | `true` | Serve user-defined agent tools. Set to false to build no MCP or REST tools anywhere and ignore the system-tool rows (a full revert to the built-in list). |
| agentTools.executionLogEnabled | bool | `true` | Record every MCP/REST call an agent makes as a row of the tool's tool_<slug> table in the customer's data DB (the audit trail is unaffected) |
| agentTools.executionLogWriteTimeoutSeconds | int | `5` | Ceiling on one execution-log write; past it the row is dropped with a warning |
| agentTools.headerValueMaxChars | int | `4096` | Maximum header value length in characters (a JWT fits) |
| agentTools.maxCallsPerInvocation | int | `10` | Default per-invocation call budget on every tool function |
| agentTools.maxConcurrentCalls | int | `20` | Per-process concurrency semaphore and egress pool size |
| agentTools.maxFunctionsPerAgent | int | `40` | Expanded tool functions one consumer may carry (the notebook, or one agent) |
| agentTools.maxHeaders | int | `20` | Request headers configurable on one tool |
| agentTools.maxPerOperator | int | `10` | Tools a single workflow agent may select |
| agentTools.maxResultImages | int | `4` | MCP image blocks attached to a notebook tool result |
| agentTools.maxUserToolsPerProject | int | `25` | MCP + REST tools a single project may define |
| agentTools.mcpMaxFunctions | int | `30` | Discovered functions kept per MCP server |
| agentTools.oauthClientMetadataCacheSeconds | int | `3600` | How long an authorization server may cache the client metadata document this deployment serves. API only |
| agentTools.oauthEnabled | bool | `true` | Allow an MCP tool to sign in to its server with OAuth. Set to false to refuse the editing routes, build nothing from connected rows, and hide the option in the panel |
| agentTools.oauthFlowTtlSeconds | int | `600` | Life of a pending sign-in: long enough to sign in at the provider and approve a consent screen, short enough that an abandoned click is not a standing authorization. API only |
| agentTools.oauthMetadataMaxBytes | int | `65536` | Cap on a fetched OAuth metadata or token-response body |
| agentTools.oauthRefreshLeaseSeconds | int | `30` | Lease held by the process performing a refresh. Must exceed the token request timeout, or two processes could spend one refresh token |
| agentTools.oauthRefreshSkewSeconds | int | `60` | Refresh an access token proactively when it expires within this window; also the window inside which a second 401 is not retried |
| agentTools.oauthStartDeadlineSeconds | int | `30` | One deadline over the whole start step (probe, protected-resource metadata, authorization-server metadata, registration), so a slow provider cannot hold the request for four timeouts in a row. API only |
| agentTools.oauthTokenRequestTimeoutSeconds | int | `10` | Timeout for one OAuth metadata fetch, registration, or token request |
| agentTools.paramDescriptionMaxChars | int | `256` | Maximum per-parameter description length |
| agentTools.privateEgressAllowlist | string | `""` | Comma-separated hostnames, hostname suffixes (".corp.internal"), or CIDRs a tool may target even though they resolve to private addresses, and for which http:// is accepted. Empty means public HTTPS only. Name hosts rather than ranges: every service on an allowlisted host becomes reachable. |
| agentTools.requestBodyMaxBytes | int | `262144` | Maximum request body, bounding argument egress |
| agentTools.responseMaxBytes | int | `262144` | Streamed read cap, counted in decoded bytes |
| agentTools.restMaxRoutes | int | `30` | Routes a single REST tool may declare |
| agentTools.resultMaxChars | int | `32000` | Result text handed to the model, in characters |
| agentTools.rowTimeBudgetSeconds | int | `360` | Each row's carve-out of its subtask's tool wall clock; a row that exhausts it fails rather than answering without its tools |
| agentTools.schemaMaxBytes | int | `16384` | Maximum serialized size of one function's parameter schema |
| agentTools.schemaMaxDepth | int | `5` | Maximum nesting depth of one function's parameter schema |
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
| api.capacityRetryAfterSeconds | int | `2` | Retry-After sent with a shed 503, honoured by the frontend's reconnect, and with the 503 for a database connection lost to a failover |
| api.capacityWaitSeconds | float | `5` | Seconds a request waits for capacity before it is rejected |
| api.dbServiceMaxConnections | int | `40` | Concurrent HTTP connections to db-service, bounding the source so a spike queues here rather than arriving as load db-service has to shed |
| api.dbThreadpoolSize | int | `64` | Threads serving blocking DB work off the event loop |
| api.documentIngestChangeBatchLimit | int | `1000` | Documents one request may ask the last ingest change for. Matches the document cap the dataset explorer fetches |
| api.embeddingDocumentTestExcerptChars | int | `200` | Characters of a failing input's text shown when an embedding document test is asked for excerpts |
| api.embeddingDocumentTestMaxBytes | int | `20971520` | Most text one embedding document test sends, in UTF-8 bytes, whatever the item count. Kept under the model-service's request limit and Cloud Run's 32 MiB request limit |
| api.embeddingDocumentTestMaxConcurrentPerAccount | int | `2` | Embedding document tests one account may have running at once on one API pod. Counted per pod, so an account's ceiling is this times the number of pods; the rate limit bounds it across pods |
| api.embeddingDocumentTestMaxItems | int | `200` | Chunks or rows an embedding document test covers by default, from the start of the document |
| api.embeddingDocumentTestMaxItemsEntire | int | `5000` | Most chunks or rows an embedding document test covers when the whole document is tested |
| api.embeddingDocumentTestPageSize | int | `500` | Chunks or rows read from the data store per request while loading a document for an embedding document test |
| api.embeddingDocumentTestRetryAfterSeconds | int | `30` | Retry-After sent, in seconds, when an account is already running its share of embedding document tests |
| api.image.name | string | `"api"` |  |
| api.image.tag | string | `""` |  |
| api.maxConcurrentRequests | int | `18` | In-flight ordinary requests one API pod accepts before it starts shedding. Sized to `database.poolSize + maxOverflow`, because a request in this class holds a connection for most of its life. On Kubernetes there is no platform concurrency behind it, so this gate is the ONLY bound -- which is why the chart checks it against the pool rather than trusting it |
| api.maxConcurrentStreams | int | `40` | Concurrent streaming requests (SSE, NDJSON, MCP waiters) one pod admits. A separate class: a stream holds a request slot for minutes and a DB connection for almost none of it, and every logged-in browser tab holds two permanently |
| api.operatorSample.maxFileBytes | int | `20971520` | Max workbench attachment size accepted by the parse-sample endpoint. The file rides to the worker as base64 JSON (~4/3 the size), so keep it at or below 20 MiB |
| api.operatorSample.parseTimeoutSeconds | int | `300` | API-side read timeout on the synchronous worker parse call, in seconds. Whole-document OCR of a large PDF via an external backend takes minutes |
| api.pydanticSchemaImportMaxChars | int | `100000` | Largest Pydantic source paste a schema import accepts, in characters. Parsing is static (no code runs), but each request parses arbitrary pasted Python |
| api.replicaCount | int | `1` |  |
| api.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| api.searchQueryMaxChars | int | `4000` | Longest search query accepted, in characters. Queries are embedded (and on the tools route sent to an LLM), so this bounds the provider cost of one search |
| api.service.port | int | `8080` |  |
| api.service.type | string | `"ClusterIP"` |  |
| api.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| api.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| api.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| api.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| api.url | string | `""` | The address browsers and third parties reach the API at. Used for the frontend's `NEXT_PUBLIC_API_URL` and, as `PUBLIC_API_URL`, for the client metadata document an authorization server fetches while a user connects an MCP tool. The chart ships no ingress, so whatever fronts the API must let `/api/oauth/client-metadata` through unauthenticated for that path to work; leave this empty and sign-ins register a client dynamically instead |
| api.validationStreamReadTimeoutSeconds | int | `120` | Read timeout between events of a streamed validation run, in seconds. One test can take a reasoning model most of a minute on large inputs |
| api.validationTokenTtlSeconds | int | `900` | How long a passing AI-settings validation lets a save of the same settings skip re-testing, in seconds |
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
| auditService.database.capacityRetryAfterSeconds | int | `2` | Retry-After sent on the 503 that pool exhaustion produces. No admission gate sits in front of this pool, so exhaustion is the overload path. Also sent with the 503 for a database connection lost to a failover |
| auditService.database.maxOverflow | int | `10` | Extra connections allowed beyond poolSize |
| auditService.database.poolSize | int | `5` | Persistent DB connections held by the pool. SQLAlchemy's own default, named explicitly so the connection budget sums a visible number |
| auditService.database.poolTimeout | int | `5` | Seconds a request waits for a connection before failing |
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
| callbackDelivery.database.capacityRetryAfterSeconds | int | `2` | Retry-After sent on the 503 that pool exhaustion produces. No admission gate sits in front of this pool, so exhaustion is the overload path. Also sent with the 503 for a database connection lost to a failover |
| callbackDelivery.database.maxOverflow | int | `10` | Extra connections allowed beyond poolSize |
| callbackDelivery.database.poolSize | int | `5` | Persistent DB connections held by the pool. SQLAlchemy's own default, named explicitly so the connection budget sums a visible number |
| callbackDelivery.database.poolTimeout | int | `5` | Seconds a request waits for a connection before failing |
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
| dataIngestor.networkPolicy.allowedPrivateCidrs | list | `[]` | Private CIDRs the data-ingestor may still reach, such as a database on a private address. Pair each with an entry in `ingest.privateEgressAllowlist`, which the service checks before connecting |
| dataIngestor.networkPolicy.enabled | bool | `false` | Create an egress NetworkPolicy for the data-ingestor pods. Off by default because in-cluster dependencies outside this release (an object store, a telemetry collector) need `extraEgress` entries first |
| dataIngestor.networkPolicy.extraEgress | list | `[]` | Extra egress rules appended as written (a list of NetworkPolicyEgressRule), for example the namespace of an in-cluster object store or OTel collector |
| dataIngestor.replicaCount | int | `1` |  |
| dataIngestor.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| dataIngestor.service.port | int | `8080` |  |
| dataIngestor.service.type | string | `"ClusterIP"` |  |
| dataIngestor.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| dataIngestor.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| dataIngestor.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| dataIngestor.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| dataIngestor.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| dataIngestor.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs). Ingest runs write their artifacts to the default blob storage (`/app/data`) and the worker reads them back, so mount the same shared volume you give `api` and `worker`. |
| database | object | `{"connectTimeoutSeconds":5,"existingSecret":"","host":"","maxConnections":"","maxOverflow":6,"name":"ragnerock","opsConnectionHeadroom":27,"password":"","poolSize":12,"poolTimeout":10,"port":5432,"readOnlyPoolResetIntervalSeconds":5,"reservedConnections":13,"user":"ragnerock"}` | Database configuration |
| database.connectTimeoutSeconds | int | `5` | Seconds every service waits to open a Postgres connection. Bounds how long a host resolving to an unresponsive address (a DNS flap during a failover) can stall startup or a request |
| database.existingSecret | string | `""` | Use a pre-existing secret (must provide key `DB_PASSWORD`) instead of generating one. When set, `password` is ignored. |
| database.maxConnections | string | `""` | Server-side connection ceiling, for the chart's own budget check. Empty leaves the check off, which is right when the chart is installed against a Postgres whose limit it cannot know. Set it and the chart refuses to render a fleet whose worst-case pools exceed it. |
| database.opsConnectionHeadroom | int | `27` | Slots held back for operators: psql, migrations, backups and any per-tenant BYODB engines, which have no pool row of their own |
| database.poolSize | int | `12` | Connections one API pod keeps open. The default is the figure the §4.1 connection budget is computed from; `api.maxConcurrentRequests` is sized against it and the chart refuses to render a gate that exceeds it |
| database.readOnlyPoolResetIntervalSeconds | float | `5` | Minimum seconds between two connection pool resets when Postgres refuses writes as read-only, so a host still pointing at a standby does not open a new connection per request |
| database.reservedConnections | int | `13` | Slots Postgres reserves for superusers and reserved roles, subtracted from the budget above |
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
| dbService.capacityRetryAfterSeconds | int | `2` | Retry-After sent with a shed, POOL_EXHAUSTED, or CONNECTION_FAILED 503 |
| dbService.capacityWaitSeconds | float | `2` | Seconds a request waits for a capacity slot before being shed |
| dbService.connectionFailureThreshold | int | `5` | Consecutive connection failures before a config is flagged for deactivation |
| dbService.defaultDBMaxOverflow | int | `20` | Overflow above the pool size for a customer database that does not specify one |
| dbService.defaultDBPoolSize | int | `20` | Connection pool size for a customer database that does not specify one |
| dbService.defaultDBStartupRetryInitialSeconds | float | `1` | Seconds before the first retry when the default data DB is unreachable or read-only at startup. The pod stays up and unready while it retries |
| dbService.defaultDBStartupRetryMaxSeconds | float | `30` | Cap on the doubling delay between those startup retries (seconds) |
| dbService.image.name | string | `"db-service"` |  |
| dbService.image.tag | string | `""` | Overwrites global value if set |
| dbService.maxConcurrentExternalRequests | string | `""` | Concurrent BYODB requests one pod admits. A separate class because a customer query runs for seconds to minutes while internal traffic is milliseconds; empty derives it from the conservative BYODB pool |
| dbService.maxConcurrentRequests | string | `""` | Concurrent requests against the DEFAULT data DB one pod admits. Empty derives it from the default pool's capacity, since every admitted request can hold at most one of its connections |
| dbService.podDisruptionBudget | object | `{"enabled":true,"maxUnavailable":1,"minAvailable":null}` | Pod disruption budget, on by default because every other service calls db-service synchronously. Set exactly one of `minAvailable`/`maxUnavailable`; the other must be null. Both accept an integer or a percentage string (e.g. `"50%"`). The default `maxUnavailable: 1` never blocks a node drain, so it only keeps db-service up through one when `replicaCount` is 2 or more. |
| dbService.poolTimeout | int | `5` | Seconds a request waits for a DB connection before the app returns 503 POOL_EXHAUSTED. At least capacityWaitSeconds, so the gate sheds first |
| dbService.queryDefaultTimeoutSeconds | int | `120` | Statement timeout (seconds) for a document query whose request carries none |
| dbService.querySlowLogThresholdMs | int | `5000` | A document query slower than this (ms) is logged with its shape and timings, never the SQL; 0 disables |
| dbService.queryWorkMem | string | `"64MB"` | Postgres work_mem for a document query's transaction (a number with a kB/MB/GB unit); the annotation pivot spills to disk at the cluster default |
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
| dbService.snowflakeInsertPageSize | int | `1000` | Rows per multi-row INSERT when SQLAlchemy pages an executemany batch on Snowflake |
| dbService.snowflakeLockTimeoutSeconds | int | `30` | How long a Snowflake statement waits for a table lock (seconds); kept under the worker's 60 s write budget |
| dbService.snowflakeStatementTimeoutSeconds | int | `600` | Ceiling for every statement on a Snowflake BYODB connection (seconds); Snowflake's own default is two days |
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
| endpoints.mcp.allowPrivateUrlInputs | bool | `false` | Let a URL input resolve to a private address or use plain http. Not the callback switch: a URL input hands the fetched bytes back through the workflow's output |
| endpoints.mcp.allowUrlInputs | bool | `true` | Offer and accept URL file inputs. Advertised in the published tool contract only when on |
| endpoints.mcp.defaultWaitSeconds | int | `55` | Wait budget, in seconds, for a call that omits `wait_seconds`. Under the TypeScript MCP SDK's absolute 60 s request timeout |
| endpoints.mcp.enabled | bool | `true` | Serve the MCP front on workflow endpoints. When false the route answers 404 |
| endpoints.mcp.keepaliveSeconds | int | `15` | Idle seconds between keepalives on a waiting stream. Under Cloudflare's 100 s ceiling on a silent origin |
| endpoints.mcp.maxBodyBytes | int | `16777216` | JSON-RPC request-body ceiling, in bytes. Bounds base64 file inputs |
| endpoints.mcp.maxWaitSeconds | int | `240` | Ceiling, in seconds, on a call's `wait_seconds`, measured from request arrival |
| endpoints.mcp.maxWaiters | int | `16` | Concurrent waiting calls one API instance will hold before answering `processing` immediately. Keep at or below half of `api.maxConcurrentStreams`: every logged-in browser tab holds two stream slots |
| endpoints.mcp.pollSeconds | int | `2` | How often, in seconds, a waiting call re-reads the execution row |
| endpoints.mcp.resultMaxBytes | int | `98304` | Serialized-envelope size, in bytes, above which a result is reduced to its document-scoped fields |
| endpoints.mcp.staleHintSeconds | int | `3600` | Elapsed seconds past which the tool contract tells an agent to stop polling a run and report it stuck |
| endpoints.mcp.urlConnectTimeoutSeconds | int | `5` | Connect timeout, in seconds, for one URL file input; short so an unreachable host fails fast instead of eating the fetch budget |
| endpoints.mcp.urlFetchBudgetSeconds | int | `30` | Wall-clock budget, in seconds, shared by every URL input of one call |
| endpoints.oauth.accessTokenTtlSeconds | int | `3600` | Lifetime of an access token, in seconds. API only |
| endpoints.oauth.authorizationCodeTtlSeconds | int | `120` | Lifetime of an authorization code, in seconds. A code crosses one redirect and is spent immediately. API only |
| endpoints.oauth.cimdCacheSeconds | int | `3600` | How long a fetched client ID metadata document is cached, in seconds. API only |
| endpoints.oauth.cimdMaxBytes | int | `65536` | Byte cap on a client ID metadata document. This is the one outbound fetch the authorization server makes to a URL a stranger chose. API only |
| endpoints.oauth.cimdTimeoutSeconds | int | `10` | Timeout on fetching a client ID metadata document, in seconds. API only |
| endpoints.oauth.dcrMaxPerDayGlobal | int | `5000` | Dynamic client registrations the whole deployment accepts per day, whoever sends them: the bound that holds even where the edge passes `X-Forwarded-For` through. Legitimate use is a few a day. API only |
| endpoints.oauth.dcrMaxPerIpPerDay | int | `20` | Dynamic client registrations one address may create per day. The MCP hosts register from shared egress addresses, so this is sized to survive a whole office behind one NAT. Keys on the client address the API sees, which is the left-most `X-Forwarded-For` entry: whatever fronts the API must set that header from the connection rather than pass a caller's own through, or a caller gets a fresh bucket per spoofed value. API only |
| endpoints.oauth.dcrUnusedClientTtlDays | int | `30` | How long a registration nobody ever consented to is kept before the maintenance CronJob's prune deletes it, in days. API only |
| endpoints.oauth.enabled | bool | `true` | Let a caller sign in to an endpoint MCP server instead of presenting a key. When false the well-known documents and every /api/oauth route answer 404 and existing tokens stop being accepted, so a host sees a deployment that never supported OAuth rather than one that advertises it and then refuses. Two install requirements, neither of which the chart can satisfy for you: `api.url` must be set, because it is the issuer every token is bound to; and **`/.well-known/*` on that host must reach the API**. The chart ships no ingress, so whatever fronts the API is what has to route those two paths — a client that cannot fetch them cannot start a sign-in at all, and sees a server with no OAuth rather than an error. API only |
| endpoints.oauth.refreshTokenTtlDays | int | `30` | Lifetime of a refresh token, in days. Sliding: every rotation issues a fresh expiry, so an app in regular use never expires and one idle this long does. API only |
| endpoints.oauth.registrationMaxBodyBytes | int | `16384` | Largest client registration body accepted, in bytes. API only |
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
| ingest.privateEgressAllowlist | string | `""` | Comma-separated hostnames, hostname suffixes (".corp.internal"), or CIDRs ingest sources (files linked from scraped pages, SQL source databases) may reach even though they resolve to private addresses. The data-ingestor enforces it at execution and the API prechecks SQL source hosts against it at save and preview. Empty means public addresses only; cloud metadata endpoints are always refused. |
| ingest.sqlAllowPrivateHosts | bool | `true` | Let SQL sources connect to databases on private addresses (RFC 1918, loopback, link-local, IPv6 unique local) without listing each host in `privateEgressAllowlist`. On by default because a self-hosted install usually ingests from databases on its own network. Applies to SQL sources only; cloud metadata endpoints are always refused. When `dataIngestor.networkPolicy.enabled` is also set, the NetworkPolicy lets the data-ingestor reach private ranges too. |
| license | string | `""` | Ragnerock provided license key |
| licenseCheck.enabled | bool | `true` | Enable license enforcement. Turning this off skips both the startup check and the periodic re-check; intended for air-gapped evaluation, not for production. |
| licenseCheck.graceSeconds | int | `259200` | How long a service may keep serving without a successful validation before it stops (default: 3 days) |
| licenseCheck.intervalSeconds | int | `86400` | Seconds between checks after a successful validation (default: once a day) |
| licenseCheck.retrySeconds | int | `3600` | Seconds between checks while the license server is unreachable |
| licenseCheck.shutdownGraceSeconds | int | `30` | Seconds allowed for graceful shutdown after a lapsed license before the process is killed |
| licenseCheck.timeoutSeconds | int | `10` | Per-request timeout for one validation call, in seconds |
| licenseExistingSecret | string | `""` | Use a pre-existing secret (must provide key `RAGNEROCK_LICENSE`) instead of generating one. When set, `license` is ignored. |
| licenseServerUrl | string | `"https://licenses.ragnerock.com"` | License server the deployment validates against |
| limits.aggregationMaxUpstreamRows | int | `10000` | Largest upstream row count an LLM aggregation node may drain into one request |
| limits.batches.annotation | int | `50` |  |
| limits.batches.embedding | int | `100` |  |
| limits.batches.rowSubtaskGrainEnabled | bool | `true` | Size ROW subtasks from settings rather than from the operator's batch_size (which is rows per LLM call, not rows per subtask) |
| limits.batches.subtaskToolElapsedCeilingSeconds | int | `900` | Ceiling on the elapsed user-tool time one subtask may spend |
| limits.batches.toolOperatorSubtask | int | `10` | Items per annotation subtask when the operator carries tools |
| limits.codeOperator.maxTimeoutSeconds | int | `30` | Largest time limit an element-scope (Row/Page/Paragraph/Sentence) code operator may declare, in seconds |
| limits.codeOperator.maxTimeoutSecondsSheet | int | `300` | Largest time limit a Sheet- or Document-scope code operator may declare, in seconds |
| limits.codeOperator.timeoutSeconds | int | `30` | Wall-clock ceiling for a code operator's execution, in seconds |
| limits.concurrency.maxConcurrentAnnotations | int | `10` |  |
| limits.concurrency.maxConcurrentJobs | int | `10` |  |
| limits.concurrency.maxConcurrentSampleParses | int | `2` | Concurrent workbench attachment parses one worker pod accepts. These are synchronous API-originated calls sharing the pod with queue deliveries, so the pool is small; excess requests shed as 503 |
| limits.concurrency.maxConcurrentSubtasks | int | `50` |  |
| limits.dbIdsPerRequest | int | `200` | Ids per request to a db-service '*-by-ids' endpoint, and the ceiling those endpoints enforce -- one value, because the client's chunk size and the server's limit are one decision. A URL byte budget: each id costs 41 bytes of request line, so 200 is about 8.2 KB, half the smallest limit in the path. |
| limits.job.watchdogSlackMinutes | int | `5` | Extra delay past the subtask claim lease (claimStaleSeconds) before the job watchdog reconciles |
| limits.notificationNodeMaxPerSubtask | int | `50` | Most inbox notifications one notification-node subtask may create. The rest collapse into a single summary, so a row-scoped node over a large sheet cannot flood the run user's inbox |
| limits.subtask.claimStaleSeconds | int | `300` | Seconds without a heartbeat before an in-flight subtask may be re-claimed; must be several times the interval and above the DB pool timeout |
| limits.subtask.failureThreshold | float | `0.05` |  |
| limits.subtask.heartbeatIntervalSeconds | int | `30` | Seconds between claim heartbeats on an in-flight subtask |
| limits.subtask.maxAttempts | int | `3` |  |
| limits.subtask.staleThresholdMinutes | int | `35` | Fallback cutoff in minutes on started_at for subtasks claimed by a pre-heartbeat revision (rollout overlap only) |
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
| maintenance.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
| maintenance.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| maintenance.backoffLimit | int | `1` | Retries within one firing. The routes are idempotent and daily, so a transient failure is better left to tomorrow's run than retried hard. |
| maintenance.enabled | bool | `true` | Run the maintenance CronJob. Disable only if you fire the internal `/api/endpoints/internal/*`, `/ingest/internal/maintenance` and `/api/oauth/internal/prune` routes some other way.  The job sends no credential. Those routes are guarded by a Google OIDC check that a Kubernetes CronJob cannot satisfy, and that check is inert unless `CALLBACK_AUTH_ENABLED` is true — which this chart never sets. In other words they are protected by network isolation: reachable only from inside the cluster, and the chart ships no ingress. If you turn `CALLBACK_AUTH_ENABLED` on through `api.extraEnv`, this job starts failing every night; disable it here and drive the routes yourself. |
| maintenance.failedJobsHistoryLimit | int | `3` |  |
| maintenance.image.name | string | `"api"` |  |
| maintenance.image.tag | string | `""` |  |
| maintenance.resources | object | `{}` | Deployment resource constraints (i.e. requests/limits) |
| maintenance.schedule | string | `"23 3 * * *"` | Cron schedule (cluster timezone). Daily, off-peak by default. An ingest run whose execution was lost keeps its source busy until this job fails it, so installs that ingest on a schedule may want it more often (every route is idempotent and bounded). |
| maintenance.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| maintenance.serviceAccount.create | bool | `false` | Create a service account for the maintenance job's pods |
| maintenance.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| maintenance.startingDeadlineSeconds | int | `600` | Skip a firing that could not start within this many seconds rather than piling up missed runs after a cluster outage. |
| maintenance.successfulJobsHistoryLimit | int | `3` |  |
| maintenance.timeoutSeconds | int | `300` | Per-route HTTP timeout. The prune and ingest maintenance routes work in bounded batches and resume at the next firing, so they never need a long one. |
| maintenance.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| memory | object | `{"schemaHardCap":100,"schemaSoftCap":25,"searchBudgetAnnotation":8,"toolsEnabled":true,"writeBudgetAnnotation":12,"writeBudgetNotebook":8}` | Agentic memory: the ops kill switch, schema-proliferation caps, and the per-run write budgets that bound a single agent's memory writes. |
| memory.schemaHardCap | int | `100` | Schemas per project past which creating another is refused |
| memory.schemaSoftCap | int | `25` | Schemas per project past which creating another is discouraged |
| memory.searchBudgetAnnotation | int | `8` | Memory searches allowed in a single annotation run |
| memory.toolsEnabled | bool | `true` | Expose the memory tools to agents. Set to false to switch memory off entirely. |
| memory.writeBudgetAnnotation | int | `12` | Memory writes allowed in a single annotation run |
| memory.writeBudgetNotebook | int | `8` | Memory writes allowed in a single notebook turn |
| messageBoard | object | `{"enabled":true,"inboxMaxAgeDays":30,"inboxMaxEntries":10,"maxBodyChars":1000,"maxHandles":20,"writeBudget":4}` | Agent message board: the ops switch (independent of memory.toolsEnabled), the message body cap, and the bounds on the inbox listing and the write budget. |
| messageBoard.enabled | bool | `true` | Expose the message board's tools to agents in projects that switch it on. |
| messageBoard.inboxMaxAgeDays | int | `30` | Days after which a message is no longer listed for anyone |
| messageBoard.inboxMaxEntries | int | `10` | Entries in one inbox listing; also the read/archive budget per invocation |
| messageBoard.maxBodyChars | int | `1000` | Characters allowed in a message body; longer posts are rejected |
| messageBoard.maxHandles | int | `20` | Agent handles named before collapsing into "(and N more)" |
| messageBoard.writeBudget | int | `4` | message_write calls allowed in a single agent invocation |
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
| model.annotateWaitSeconds | int | `120` | Seconds a client-side /annotate call waits for one of those slots before failing in-band. The failure is classified retryable, so reaching it costs a redelivery rather than a failed row |
| model.annotatorNoChainMaxAttempts | int | `8` | Annotator attempts when no fallback chain is configured |
| model.annotatorRetryBudgetSeconds | int | `420` | Wall-clock budget for annotator retries, in seconds |
| model.anthropicMaxOutputTokens | int | `8192` | Anthropic response-length ceiling (tokens); with thinking, max_tokens = thinking budget + this |
| model.anthropicThinkingBudgetHigh | int | `16384` | Anthropic thinking token budget for the HIGH effort tier |
| model.anthropicThinkingBudgetLow | int | `4096` | Anthropic thinking token budget for the LOW effort tier |
| model.anthropicThinkingBudgetMedium | int | `8192` | Anthropic thinking token budget for the MEDIUM effort tier |
| model.embeddingDocumentTestBatchSize | int | `32` | Inputs sent to the embedding provider per request when testing embedding settings against a document |
| model.embeddingDocumentTestBatchTimeoutSeconds | int | `60` | Longest one provider request of an embedding document test may take, in seconds. A slower request becomes a finding instead of holding the run until the overall limit |
| model.embeddingDocumentTestHeartbeatSeconds | int | `10` | Seconds between progress events while an embedding document test waits on a provider request, so a slow request does not look like a dead connection |
| model.embeddingDocumentTestMaxConcurrentPerAccount | int | `2` | Embedding document tests one account may have running at once on one model-service instance |
| model.embeddingDocumentTestMaxDetails | int | `100` | Most findings an embedding document test lists per check |
| model.embeddingDocumentTestMaxFailures | int | `20` | Failed inputs after which an embedding document test stops trying more |
| model.embeddingDocumentTestMaxSeconds | int | `240` | Longest an embedding document test may run before the model-service ends it, in seconds. Kept under the API's read timeout between events plus its heartbeats so the model-service ends the run before the API gives up on it |
| model.embeddingDocumentTestMessageMaxChars | int | `1000` | Characters of a provider error message kept in an embedding document test finding |
| model.embeddingDocumentTestRequestMaxItems | int | `5000` | Most inputs one embedding document test request may carry; a request with more is refused before anything is embedded |
| model.embeddingDocumentTestRequestMaxTextBytes | int | `25165824` | Most text one embedding document test request may carry, in UTF-8 bytes. Kept under Cloud Run's 32 MiB request limit |
| model.embeddingMaxConcurrentBatches | int | `8` | Provider requests one embedding call runs at once |
| model.embeddingMaxWindowsPerInput | int | `64` | Most windows one over-limit embedding input is split into; text past the last window is not embedded |
| model.geminiMaxOutputTokens | int | `32768` | Output-token ceiling for the default Gemini provider |
| model.geminiModelName | string | `"gemini-3.8-flash"` |  |
| model.geminiThinkingBudgetHigh | int | `24576` | Gemini thinking token budget for the HIGH effort tier |
| model.geminiThinkingBudgetLow | int | `1024` | Gemini thinking token budget for the LOW effort tier |
| model.geminiThinkingBudgetMedium | int | `8192` | Gemini thinking token budget for the MEDIUM effort tier |
| model.geminiThinkingLevel | string | `"LOW"` | Gemini thinking budget: `LOW`, `MEDIUM`, or `HIGH` |
| model.geminiTruncationRetries | int | `1` | Retries when a Gemini response comes back truncated |
| model.httpTimeoutSeconds | int | `180` |  |
| model.maxConcurrentAnnotateCalls | int | `50` | Concurrent POSTs to model-service /annotate from one client process |
| model.maxConcurrentAnnotationTargets | int | `50` | Annotation targets in flight at once across every subtask one worker process is serving. The per-row limiters (web tools, agent tools, the /annotate gate) are sized against this, not against maxConcurrentSubtasks x maxConcurrentAnnotations |
| model.maxConcurrentProviderCalls | int | `50` | Provider calls the model-service will have in flight at once |
| model.openaiUseResponsesApi | bool | `false` | Route OpenAI calls through the Responses API (enables encrypted reasoning items) |
| model.providerCallRetryAfterSeconds | int | `5` | Retry-After sent on a provider-call shed |
| model.providerCallWaitSeconds | int | `30` | How long a request waits for a provider-call slot before the gate sheds it with 503 + Retry-After |
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
| notebook | object | `{"auditTurnSnapshot":false,"compactionTimeoutSeconds":120}` | Notebook agent rollout flags and the compaction-call timeout. |
| notebook.auditTurnSnapshot | bool | `false` | Rollout flag: capture a full history snapshot on the first iteration of every notebook turn so the audit record is exactly replayable |
| notebook.compactionTimeoutSeconds | int | `120` | Wall-clock bound (seconds) on the one-shot notebook-compaction summarization call |
| otel | object | `{"authHeader":"","enabled":false,"existingSecret":"","exporterEndpoint":"","exporterInsecure":false,"exporterProtocol":"http/protobuf","serviceNamespace":"ragnerock","servicePrefix":""}` | Otel metrics/traces/logs export |
| otel.existingSecret | string | `""` | Use a pre-existing secret (must provide key `OTEL_EXPORTER_OTLP_HEADERS`) instead of generating one. When set, `authHeader` is ignored. |
| otel.serviceNamespace | string | `"ragnerock"` | OTEL service namespace |
| otel.servicePrefix | string | `""` | Optional prefix for otel service names. E.g., setting servicePrefix to `foobar` changes api -> foobarapi |
| pull | object | `{"fetchBackoffBaseSeconds":2,"fetchBackoffCapSeconds":30,"fetchMaxBytes":33554432,"fetchTimeoutSeconds":60,"maxFetchRetries":10,"maxResourcesPerWorkflow":10,"phaseTimeBudgetSeconds":900,"testFetchMaxBytes":4194304,"toolCallArgumentsMaxBytes":16384}` | Pull inputs: the bounds on what a workflow may fetch for itself on each run, and the workers' budget for fetching it. |
| pull.fetchBackoffBaseSeconds | float | `2` | Workers: first backoff between attempts of one resource's fetch, in seconds, doubling per attempt. |
| pull.fetchBackoffCapSeconds | float | `30` | Workers: ceiling on that backoff, in seconds. |
| pull.fetchMaxBytes | int | `33554432` | Per-fetch body cap, in bytes. A pull stores the payload as a document, so this is what a document may weigh, not what fits a context window. |
| pull.fetchTimeoutSeconds | int | `60` | Per-attempt wall clock on one fetch, in seconds; the agent-tool call ceiling and the route or tool's own ceiling still apply. |
| pull.maxFetchRetries | int | `10` | Retries per pull resource within one delivery. Bounds the multiplier on calls to somebody else's server. |
| pull.maxResourcesPerWorkflow | int | `10` | Pull-sourced resources per workflow; each is an external call on every run. |
| pull.phaseTimeBudgetSeconds | int | `900` | Workers: wall clock for a run's FETCHING phase, in seconds, across all of its pull resources. |
| pull.testFetchMaxBytes | int | `4194304` | Body cap for the resource editor's Test fetch, in bytes. |
| pull.toolCallArgumentsMaxBytes | int | `16384` | Save-time cap on a tool_call source's rendered arguments, in bytes. |
| python | object | `{"batchChunkItemsMax":200,"chunkConcurrency":2,"maxAttempts":4,"maxInflight":4,"maxRequestBytes":48000000,"timeoutMarginSeconds":60}` | Client-side knobs used by callers of python-service (API and workers). The sandbox's own configuration lives under `pythonService.sandbox`. |
| python.batchChunkItemsMax | int | `200` | Upper bound on items per chunk; the count used is derived from the operator's time limit |
| python.chunkConcurrency | int | `2` | Chunks of one batch dispatched concurrently |
| python.maxAttempts | int | `4` | Attempts per execution request before giving up |
| python.maxInflight | int | `4` | Concurrent python-service requests one worker process may have in flight |
| python.maxRequestBytes | int | `48000000` | Request payload ceiling enforced before send, in bytes |
| python.timeoutMarginSeconds | float | `60` | Seconds added to the execution budget to form the HTTP read timeout |
| pythonService.affinity | object | `{}` | Pod affinity rules (overrides `global.affinity`) |
| pythonService.annotations | object | `{}` | Annotations added to this workload's metadata (merged with `global.annotations`; per-service keys take precedence) |
| pythonService.automountServiceAccountToken | bool | `false` | Mount the Kubernetes API token. User code can read it, so leave this off unless something needs it |
| pythonService.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| pythonService.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| pythonService.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| pythonService.image.name | string | `"python-service"` |  |
| pythonService.image.tag | string | `""` | Overwrites global value if set |
| pythonService.podSecurityContext | object | `{"runAsGroup":1338,"runAsNonRoot":true,"runAsUser":1774}` | Pod security context. The UID/GID are the image's `pysandbox` user; sharing a UID with other workloads shares their RLIMIT_NPROC budget |
| pythonService.replicaCount | int | `1` | Each pod runs one execution at a time and turns away the rest with a 503, so size this to the workers' total `python.maxInflight` |
| pythonService.requestTimeoutSeconds | int | `600` | Request timeout the service is deployed with; its clients size their chunking against it |
| pythonService.resources | object | `{}` | Deployment resoruce contraints (i.e. requests/limits) |
| pythonService.sandbox | object | `{"batchStartupGraceSeconds":15,"busyRetryAfterSeconds":1,"enforcement":"on","maxOutputBytes":1000000,"maxRequestBytes":48000000,"maxResponseBytes":30000000,"maxResultBytes":8000000,"maxStateBytes":20000000,"maxStateVariableBytes":20000000,"maxTimeout":300,"nativeThreads":2,"recycleAfterNExecutions":100,"rlimitCPUHeadroomSeconds":30,"rlimitCPUPerWallSecond":2,"rlimitCPUSeconds":60,"rlimitFSizeBytes":64000000,"rlimitNProc":512,"rlimitNoFile":256,"stateGraceSeconds":10}` | Sandbox limits the code-execution service applies to user code |
| pythonService.sandbox.batchStartupGraceSeconds | float | `15` | Extra wall-clock allowed for subprocess spawn and the first heavy import |
| pythonService.sandbox.busyRetryAfterSeconds | int | `1` | Retry-After, in seconds, on the 503 a pod returns while it is already running an execution |
| pythonService.sandbox.enforcement | string | `"on"` | `on` requires the Linux sandbox mechanisms; `off` is a local-dev escape hatch only |
| pythonService.sandbox.maxOutputBytes | int | `1000000` | stdout/stderr capture cap, in bytes |
| pythonService.sandbox.maxRequestBytes | int | `48000000` | Request payload ceiling enforced on receipt, in bytes |
| pythonService.sandbox.maxResponseBytes | int | `30000000` | Combined response ceiling in bytes, sized under the ingress body cap so an oversized capture fails with a real message rather than a truncated connection |
| pythonService.sandbox.maxResultBytes | int | `8000000` | Per-result size ceiling, in bytes |
| pythonService.sandbox.maxStateBytes | int | `20000000` | Ceiling on one notebook session's serialized state, in bytes |
| pythonService.sandbox.maxStateVariableBytes | int | `20000000` | Per-variable ceiling within a state capture, in bytes; a single oversized object is dropped and reported rather than failing the cell |
| pythonService.sandbox.maxTimeout | int | `300` | Wall-clock ceiling applied to every execution, in seconds |
| pythonService.sandbox.nativeThreads | int | `2` | Threads per native pool (OpenMP, OpenBLAS, MKL, numexpr) in user code; match the pod's CPU limit |
| pythonService.sandbox.recycleAfterNExecutions | int | `100` | Exit cleanly after this many executions; <= 0 disables recycling |
| pythonService.sandbox.rlimitCPUHeadroomSeconds | int | `30` | CPU-seconds of slack above the scaled backstop, for the startup CPU boost. Not a per-execution budget; the wall clock is. |
| pythonService.sandbox.rlimitCPUPerWallSecond | int | `2` | CPU-seconds the backstop allows per second of wall budget (the instance's core count) |
| pythonService.sandbox.rlimitCPUSeconds | int | `60` | CPU-seconds backstop behind the wall-clock timeout; a floor, scaled by the execution's wall budget |
| pythonService.sandbox.rlimitFSizeBytes | int | `64000000` | Largest file the child may write, in bytes |
| pythonService.sandbox.rlimitNProc | int | `512` | Process and thread cap for the service's UID, counted across the whole node (must not starve numpy threads) |
| pythonService.sandbox.rlimitNoFile | int | `256` | Open file descriptor cap |
| pythonService.sandbox.stateGraceSeconds | float | `10` | Extra wall-clock beyond a stateful cell's own budget for serializing its session state, in seconds |
| pythonService.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]}}` | Container security context |
| pythonService.service.port | int | `8080` |  |
| pythonService.service.type | string | `"ClusterIP"` |  |
| pythonService.serviceAccount.annotations | object | `{}` | Annotations to add to the created service account (e.g. for workload identity) |
| pythonService.serviceAccount.create | bool | `false` | Create a service account for this deployment's pods |
| pythonService.serviceAccount.name | string | `""` | Service account name to use; if empty and `create` is true a name is generated |
| pythonService.spreadAcrossNodes | bool | `true` | Prefer scheduling replicas on different nodes, since replicas on one node share a process budget |
| pythonService.tolerations | list | `[]` | Pod tolerations (overrides `global.tolerations`) |
| pythonService.volumeMounts | list | `[]` | Container volume mounts (list of Kubernetes volumeMount specs) |
| pythonService.volumes | list | `[]` | Pod volumes to mount into the deployment (list of Kubernetes volume specs) |
| query | object | `{"assistQueryTimeoutSeconds":30,"metadataCacheTTLSeconds":10}` | Document-query layer (API and worker) |
| query.assistQueryTimeoutSeconds | int | `30` | Statement timeout (seconds) for the query-assist sub-agent's probe queries |
| query.metadataCacheTTLSeconds | int | `10` | Seconds the query-layer metadata (annotation schemas, agents, datasets) is cached per project in-process; 0 disables |
| queue | object | `{"affinity":{},"annotations":{},"auditExportQueueName":"audit-export-runs","auditQueueName":"ragnerock-audit","autoscaling":{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80},"callbackQueueName":"ragnerock-callbacks","ingestRunsQueueName":"ingest-runs","jobQueueName":"ragnerock-document-jobs","port":8123,"queuePoolSize":100,"resources":{},"serviceAccount":{"annotations":{},"create":false,"name":""},"subtaskQueueName":"ragnerock-subtask-jobs","tolerations":[],"volumeMounts":[],"volumes":[]}` | Cloudtask configuration for use with in-cluster emulator |
| queue.affinity | object | `{}` | Pod affinity rules for the queue deployment (overrides `global.affinity`) |
| queue.annotations | object | `{}` | Annotations added to the queue deployment's metadata (merged with `global.annotations`; per-service keys take precedence) |
| queue.auditExportQueueName | string | `"audit-export-runs"` | Queue the audit-service enqueues its own /audit/export-run tasks onto |
| queue.autoscaling | object | `{"enabled":false,"maxReplicas":5,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":80}` | Optional horizontal pod autoscaler. Requires CPU/memory requests to be set under `resources` for the targeted metrics to work. When enabled, `replicaCount` is ignored (the HPA manages the replica count). |
| queue.autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization (% of requests). Set to null to disable. |
| queue.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target average memory utilization (% of requests). Set to null to disable. |
| queue.ingestRunsQueueName | string | `"ingest-runs"` | Queue the API sends ingest runs to the data-ingestor on |
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
| rateLimits.agentToolOauthPerMinute | int | `10` | Per-user limit on starting a sign-in for an MCP tool; each start is a metadata fetch, an authorization-server fetch, and often a client registration at a third party |
| rateLimits.agentToolProbesPerMinute | int | `30` | Agent-tool probes (REST route test, MCP discovery preview) |
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
| rateLimits.embeddingDocumentTestPerMinute | int | `4` | Per-user limit on embedding document tests, each of which embeds up to thousands of a document's chunks or rows |
| rateLimits.frontendEventsPerMinute | int | `600` |  |
| rateLimits.iamMutationPerMinute | int | `60` |  |
| rateLimits.ingestTriggerPerMinute | int | `20` |  |
| rateLimits.liveLogClientPerMinute | int | `30` | Per-user limit on the browser log relay endpoint |
| rateLimits.liveLogStreamPerMinute | int | `10` | Per-user limit on opening the live-log tail |
| rateLimits.notebookCellExecutePerMinute | int | `60` | Per-user limit on server-side notebook cell runs; each holds a python-service instance for the cell's whole wall-clock budget |
| rateLimits.notebookCodeFeedbackPerMinute | int | `40` |  |
| rateLimits.notebookCompactionPerMinute | int | `10` |  |
| rateLimits.notificationStreamPerMinute | int | `10` |  |
| rateLimits.oauthAuthorizePerMinute | int | `30` | Per-user limit on the signed-in OAuth routes (authorize, decision, grants); an authorize request can make the API fetch a client metadata document from a host the caller chose |
| rateLimits.oauthPerMinute | int | `30` | Per-IP limit on the public OAuth routes, whose callers are authorization servers and carry no session |
| rateLimits.operatorParseSamplePerMinute | int | `10` | Per-user limit on workbench attachment parses. Each request can hold a synchronous worker OCR call for minutes, so the ceiling is deliberately low |
| rateLimits.operatorTestPerMinute | int | `60` |  |
| rateLimits.pydanticSchemaImportPerMinute | int | `30` |  |
| rateLimits.queryAssistPerMinute | int | `30` |  |
| rateLimits.queryExecutePerMinute | int | `120` |  |
| rateLimits.queryValidatePerMinute | int | `60` |  |
| rateLimits.requestsPerMinute | int | `600` |  |
| rateLimits.schedulePreviewPerMinute | int | `60` | Per-user limit on the schedule editor's next-three-fires preview, a keystroke-driven route |
| rateLimits.searchPerMinute | int | `60` |  |
| rateLimits.toolsPerMinute | int | `60` |  |
| rateLimits.webSearchProbesPerMinute | int | `30` | Per-user limit on the admin page's search-provider Test button — an admin-driven, BILLED query against the workspace's own key |
| rateLimits.windowMinutes | int | `1` |  |
| rateLimits.workbenchPerMinute | int | `10` |  |
| rateLimits.workflowTestConditionPerMinute | int | `120` |  |
| schedules | object | `{"claimTtlSeconds":120,"enabled":true,"localTickSeconds":60,"maxConsecutiveFailures":5,"maxLookbackSeconds":7776000,"maxPerProject":50,"maxWindowIntervals":7,"minIntervalSeconds":300,"tickClaimBatchSize":20,"tickSource":"inprocess","tickTimeBudgetSeconds":35}` | Scheduled runs: the ops kill switch, who drives the tick, and the save-time, window, failure, and lease bounds. |
| schedules.claimTtlSeconds | int | `120` | Seconds a tick's lease on a claimed row lasts. The lease, not the row lock, keeps the next tick off a row this one is still working on. |
| schedules.enabled | bool | `true` | Let workflows run themselves on a crontab. Off: schedule edits are refused with the deployment-level reason and, under `inprocess`, the ticker is not started at all (no heartbeat, readiness lag `null`). |
| schedules.localTickSeconds | int | `60` | How often each API replica ticks, in seconds. |
| schedules.maxConsecutiveFailures | int | `5` | Failed fires, failed runs, and overlap skips in a row before a schedule pauses itself and tells its owner. |
| schedules.maxLookbackSeconds | int | `7776000` | The widest history one fire may declare it needs, in seconds. A lookback is exempt from the window cap, so it is the one number an author can use to ask for an unbounded pull. |
| schedules.maxPerProject | int | `50` | Enabled schedules per project. |
| schedules.maxWindowIntervals | int | `7` | How many of its own periods one fire's window may span before it is cut and flagged. Bounds what dormancy accumulates; never narrows a declared lookback. |
| schedules.minIntervalSeconds | int | `300` | Save-time floor on how often a schedule may fire, in seconds. A schedule is unattended recurring egress and spend. |
| schedules.tickClaimBatchSize | int | `20` | Due rows leased per claim statement within one tick. |
| schedules.tickSource | string | `"inprocess"` | Who drives the tick. Pods run continuously, so `inprocess` is right for Kubernetes; `external` means something POSTs /api/jobs/internal/schedule-tick and the lifespan starts nothing. |
| schedules.tickTimeBudgetSeconds | int | `35` | Wall clock for one tick, in seconds: the only cap on how much it does, and what spreads a burst of due schedules across minutes. |
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
| subtaskWorker.maxConcurrentAnnotationTargets | string | `nil` | This deployment's own ceiling on annotation targets in flight per process, when it should differ from `model.maxConcurrentAnnotationTargets`. The fleet's rows-in-flight lever: the pool is derived from subtasks, not targets, so it provisions no database connections; a memory or message-board tool call still takes a pooled connection while it runs, so the pool's peak demand rises with it, and a pool timeout there is a transient row failure redelivered like any other overload. Null falls back to the shared value |
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
| subtaskWorker.webToolMaxConcurrentCalls | string | `nil` | This deployment's own per-process limiter for web tool calls, when it should differ from `webTools.maxConcurrentCalls`. Raise it with `maxConcurrentAnnotationTargets` to keep the ratio the annotation queue wait is sized against. Null falls back to the shared value |
| tabular | object | `{"listPageSize":20,"promptMaxColumns":20,"promptMaxSources":10,"readRowsPerPage":50}` | Tabular documents: page sizes for reads and the shape of the table summaries rendered into prompts. |
| tabular.listPageSize | int | `20` | Rows returned per page when an agent lists a tabular document |
| tabular.promptMaxColumns | int | `20` | Columns of a table described in a prompt |
| tabular.promptMaxSources | int | `10` | Tables described in a single prompt |
| tabular.readRowsPerPage | int | `50` | Rows returned per page when an agent reads a tabular document |
| tools.codeToolTimeoutSeconds | int | `30` |  |
| tools.maxResultImages | int | `10` | Cap on images attached to a single agent tool result |
| webTools | object | `{"auditResultMaxChars":8000,"cacheMaxBytes":16777216,"cacheMaxEntries":64,"enabled":true,"fetchAllowHttp":false,"fetchBlocklistExtra":[],"fetchExtractThreads":2,"fetchMaxBytes":5242880,"fetchMaxConcurrentPdf":2,"fetchMaxConcurrentPerHost":2,"fetchMaxRedirects":5,"fetchPdfMaxBytes":33554432,"fetchPdfMaxPages":50,"fetchRespectRobots":true,"fetchResultMaxChars":32000,"fetchRobotsCacheTtlSeconds":3600,"fetchRobotsTimeoutSeconds":5,"fetchTimeoutSeconds":45,"maxConcurrentCalls":10,"privateEgressAllowlist":"","saveMetadataMaxChars":256,"savePagesEnabled":true,"saveTimeoutSeconds":10,"saveVersionScanLimit":25,"searchAccountDailyCap":5000,"searchBraveUrl":"https://api.search.brave.com/res/v1/web/search","searchDefaultResults":10,"searchMaxCallsPerInvocation":3,"searchMaxCallsPerTurn":5,"searchMaxResults":20,"searchRetryAttempts":2,"searchTimeoutSeconds":15,"userAgent":"RagnerockBot/1 (+https://ragnerock.com/bot)"}` | Web access: the ops kill switch plus the egress, size, and budget bounds for the web_search and web_fetch tools agents reach the open web with. |
| webTools.auditResultMaxChars | int | `8000` | Cap on the agent-visible text carried in a web tool's audit payload |
| webTools.cacheMaxBytes | int | `16777216` | Bytes held in the per-build web cache |
| webTools.cacheMaxEntries | int | `64` | Pages held in the per-build web cache |
| webTools.enabled | bool | `true` | Serve the web_search and web_fetch tools. Set to false to build neither anywhere, resolve every account to no web access, and refuse the configuration API. |
| webTools.fetchAllowHttp | bool | `false` | Accept plain http://. When false, http:// URLs are upgraded to https:// on the initial URL and every redirect hop, and public targets may use port 443 only. |
| webTools.fetchBlocklistExtra | list | `[]` | Extra hostnames, hostname suffixes, or CIDRs web_fetch may never reach, on top of this release's own Service names (seeded automatically). List the deployment's public hostnames and any service that trusts this cluster's egress address without a credential. |
| webTools.fetchExtractThreads | int | `2` | Threads in the dedicated extraction executor |
| webTools.fetchMaxBytes | int | `5242880` | Decoded read cap for HTML, text, and JSON responses |
| webTools.fetchMaxConcurrentPdf | int | `2` | In-flight PDF downloads per process; times `fetchPdfMaxBytes` is the memory worst case the API and worker limits must cover |
| webTools.fetchMaxConcurrentPerHost | int | `2` | In-flight fetches per process per dialled host, page and robots alike |
| webTools.fetchMaxRedirects | int | `5` | Redirect hops followed, each re-validated and re-pinned |
| webTools.fetchPdfMaxBytes | int | `33554432` | Read cap for PDFs, which are read whole into memory |
| webTools.fetchPdfMaxPages | int | `50` | Pages of text layer extracted from one PDF |
| webTools.fetchRespectRobots | bool | `true` | Honor robots.txt allow and disallow rules per RFC 9309. Turn off only for intranets whose blanket Disallow targets public crawlers. |
| webTools.fetchResultMaxChars | int | `32000` | Markdown handed to the model per fetch call; it pages past this |
| webTools.fetchRobotsCacheTtlSeconds | int | `3600` | Process-level TTL for parsed and 4xx robots verdicts |
| webTools.fetchRobotsTimeoutSeconds | int | `5` | Timeout for one robots.txt request |
| webTools.fetchTimeoutSeconds | int | `45` | Wall clock for one fetch, extraction included |
| webTools.maxConcurrentCalls | int | `10` | Per-process limiter for all web calls, separate from `agentTools.maxConcurrentCalls`; also sizes the web client's connection pool |
| webTools.privateEgressAllowlist | string | `""` | Comma-separated hostnames, hostname suffixes (".corp.internal"), or CIDRs a MODEL-CHOSEN url may reach even though they resolve to private addresses, and which are exempt from the public-port rule. Empty means public only. Deliberately separate from `agentTools.privateEgressAllowlist`: that list is for URLs an editor typed, this one for URLs a search result suggested. |
| webTools.saveMetadataMaxChars | int | `256` | Truncation bound on a metadata value the page archive writes, chiefly the page title |
| webTools.savePagesEnabled | bool | `true` | File every page web_fetch reads as a document in the project's "Web pages" dataset. No parsing, chunking or embedding happens then: the page is visible and selectable, and a workflow run over it does the rest. False leaves web_fetch behaving exactly as it did before. |
| webTools.saveTimeoutSeconds | int | `10` | Wall clock for filing one fetched page. Nested inside `fetchTimeoutSeconds` and failing open, so a slow blob backend never costs the agent its page. |
| webTools.saveVersionScanLimit | int | `25` | Stored versions of one URL examined for a byte-for-byte match before a new document is created |
| webTools.searchAccountDailyCap | int | `5000` | Default billed searches per account per rolling day; an account administrator can override it per workspace |
| webTools.searchBraveUrl | string | `"https://api.search.brave.com/res/v1/web/search"` | Where the Brave adapter sends its query. Point it at a vendor proxy if this cluster reaches the provider through one; changing it changes where each workspace's search key is sent |
| webTools.searchDefaultResults | int | `10` | Search results returned when the model names no count |
| webTools.searchMaxCallsPerInvocation | int | `3` | Searches an operator may make per target document |
| webTools.searchMaxCallsPerTurn | int | `5` | Searches the notebook agent may make in one turn |
| webTools.searchMaxResults | int | `20` | Ceiling a model-supplied result count is clamped to |
| webTools.searchRetryAttempts | int | `2` | Retries on a 429 or 503 from the search provider, honoring Retry-After |
| webTools.searchTimeoutSeconds | int | `15` | Wall clock for one search call, retries included |
| webTools.userAgent | string | `"RagnerockBot/1 (+https://ragnerock.com/bot)"` | User-Agent the web tools send. Its product token is what robots.txt is matched against, and the URL must resolve to a page describing the bot. |
| workbench.autoEnabled | bool | `true` | Kill switch for the workbench auto-iterate loop. Disabled, the chat and try-it-out surfaces keep working; only the autonomous loop is refused. |
| workbench.autoMaxCycles | int | `5` | Max apply/run tool calls per workbench auto session |
| workbench.autoMaxIterations | int | `40` | Runner backstop: max agent-loop iterations for one auto session |
| workbench.autoMaxTargets | int | `5` | Clamp on the per-run target count in workbench auto mode |
| workbench.autoTokenBudget | int | `300000` | Cost-weighted token budget for one workbench auto session. Charged the run's real model spend, not just agent-side tokens. |
| workbench.debugSessionRetention | int | `20` | How many DebugSessions to keep per (workflow, user) |
| workbench.runResultMaxCharsPerNode | int | `4000` | Per-node cap when condensing a workbench run's debug steps for the agent, in characters |
| workbench.snapshotRetention | int | `10` | How many workbench restore points to keep per workflow |
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
| workers | object | `{"capacityRetryAfterSeconds":5,"capacityWaitSeconds":5,"chunkThreadpoolSize":2,"codeSession":{"sweepBatchSize":200,"sweepEnabled":true,"sweepGraceHours":24,"sweepIntervalSeconds":3600,"ttlDays":30},"database":{"completionLockSlowMs":1000,"lockTimeoutSeconds":30,"maxOverflow":null,"poolHeadroom":5,"poolSize":null,"poolTimeout":10,"subtaskMaxOverflow":null,"subtaskPoolSize":null},"dbServiceMaxConnections":40,"dbThreadpoolSize":80,"maxChunkTokens":1500,"maxConcurrentJobAdvances":10,"maxConcurrentSpawns":5,"maxInstanceRequestConcurrency":"","reconcile":{"batchSize":100,"enabled":true,"inProgressAfterSeconds":2700,"intervalSeconds":300,"notStartedAfterSeconds":900},"spawn":{"pageSize":1000,"planningStaleSeconds":900,"timeBudgetSeconds":300},"subtaskEnqueueStaleMinutes":15,"subtaskInsertChunkRows":5000,"subtaskPublishConcurrency":32,"tabularIngest":{"maxRowsPerSheet":100000,"rowInsertChunkBytes":8000000,"rowInsertChunkRows":1000,"rowRefsPageSize":10000}}` | Settings shared by the worker and subtask-worker deployments. Both run the same job-processing code, so they are tuned together. |
| workers.capacityRetryAfterSeconds | int | `5` | Retry-After sent with a shed, pool-exhausted, or lost-connection 503; the queue honours it as backoff, so a saturated instance gets a delayed redelivery rather than an immediate one that finds it just as full |
| workers.capacityWaitSeconds | float | `5` | Seconds a task waits for local capacity before it is deferred |
| workers.chunkThreadpoolSize | int | `2` | Threads for chunking parsed pages. Chunking is CPU work, so more threads than CPUs only adds contention |
| workers.codeSession | object | `{"sweepBatchSize":200,"sweepEnabled":true,"sweepGraceHours":24,"sweepIntervalSeconds":3600,"ttlDays":30}` | Periodic sweep of notebook sandbox session state: idle purge plus collection of state objects no session references any more. |
| workers.codeSession.sweepBatchSize | int | `200` | Idle sessions purged per sweep |
| workers.codeSession.sweepEnabled | bool | `true` | Run the session-state sweep. Off means no state cleanup at all, so objects accumulate until it is turned back on |
| workers.codeSession.sweepGraceHours | int | `24` | Age below which an unreferenced state object is left alone, protecting an in-flight load or save from collection mid-turn |
| workers.codeSession.sweepIntervalSeconds | int | `3600` | Seconds between sweeps |
| workers.codeSession.ttlDays | int | `30` | Days a session may go untouched before the sweep ends it |
| workers.database.completionLockSlowMs | int | `1000` | Milliseconds a subtask completion may wait on the job row's lock before warning |
| workers.database.lockTimeoutSeconds | int | `30` | Seconds a statement waits on a row lock before erroring |
| workers.database.maxOverflow | string | `nil` | Explicit overflow above the pool size. Falls back to `poolHeadroom` when null. |
| workers.database.poolHeadroom | int | `5` | Connections kept spare on top of the derived pool size, for non-request work |
| workers.database.poolSize | string | `nil` | Explicit connection pool size. Derived from the concurrency limits plus `poolHeadroom` when null, mirroring the worker's own in-process derivation. |
| workers.database.poolTimeout | int | `10` | Seconds a checkout waits for a free pooled connection |
| workers.database.subtaskMaxOverflow | string | `nil` | The subtask worker's own overflow; null falls back to `maxOverflow`. |
| workers.database.subtaskPoolSize | string | `nil` | The SUBTASK worker's own pool size, when it should differ from the plain worker's. Both deployments run one image and share this ConfigMap, but not the work: at concurrency 1 the plain worker never serves a subtask, so a pool sized for `maxConcurrentSubtasks` is one it holds open for nothing. Null falls back to `poolSize`. |
| workers.dbServiceMaxConnections | int | `40` | Concurrent HTTP connections to db-service, bounding the source |
| workers.dbThreadpoolSize | int | `80` | Threads serving blocking DB work off the event loop |
| workers.maxChunkTokens | int | `1500` | Preferred maximum tokens per chunk when a document is split for embedding. Chunks are also capped by the embedding provider's own limit, whichever is smaller. |
| workers.maxConcurrentJobAdvances | int | `10` | Concurrent job phase-advances a worker process may run |
| workers.maxConcurrentSpawns | int | `5` | Concurrent spawn continuations a worker process may run. A node whose subtasks take longer than `spawn.timeBudgetSeconds` to publish continues on a later delivery; those get their own pool so one large job's paging cannot queue behind every other job's phase advances. |
| workers.maxInstanceRequestConcurrency | string | `""` | Requests one pod is allowed to serve at once, as configured on the platform. Caps the derived DB pool at what can actually arrive; empty leaves the derivation to the concurrency semaphores alone |
| workers.reconcile | object | `{"batchSize":100,"enabled":true,"inProgressAfterSeconds":2700,"intervalSeconds":300,"notStartedAfterSeconds":900}` | Periodic DB sweep that re-enqueues jobs whose queue deliveries were dropped after exhausting their retry budget. |
| workers.reconcile.batchSize | int | `100` | Jobs examined per sweep |
| workers.reconcile.enabled | bool | `true` | Run the reconciliation sweep |
| workers.reconcile.inProgressAfterSeconds | int | `2700` | Seconds a job may sit in progress before the sweep re-enqueues it |
| workers.reconcile.intervalSeconds | int | `300` | Seconds between sweeps |
| workers.reconcile.notStartedAfterSeconds | int | `900` | Seconds a job may sit unstarted before the sweep re-enqueues it |
| workers.spawn.pageSize | int | `1000` | Subtasks published per page of a spawn |
| workers.spawn.planningStaleSeconds | int | `900` | Seconds a claimed-but-unfinished plan may sit before another delivery takes it over, so a planner that died cannot hang the node forever |
| workers.spawn.timeBudgetSeconds | int | `300` | Wall clock one spawn delivery may spend publishing before handing the rest to a continuation. Must stay well under the queue's dispatch deadline, or the delivery is killed mid-page instead of stopping cleanly. |
| workers.subtaskEnqueueStaleMinutes | int | `15` | Minutes after a subtask's publish past which reconciliation republishes it |
| workers.subtaskInsertChunkRows | int | `5000` | Subtask rows per multi-row INSERT when a plan is persisted. The plan still commits in one transaction; this bounds each statement in it. |
| workers.subtaskPublishConcurrency | int | `32` | Concurrent Cloud Tasks publishes during a subtask spawn |
| workers.tabularIngest.maxRowsPerSheet | int | `100000` | Rows a single parsed sheet may hold before the parse fails explicitly |
| workers.tabularIngest.rowInsertChunkBytes | int | `8000000` | Byte ceiling per tabular row-insert request (binds first on a wide sheet) |
| workers.tabularIngest.rowInsertChunkRows | int | `1000` | Rows per db-service insert request when ingesting a tabular document |
| workers.tabularIngest.rowRefsPageSize | int | `10000` | Tabular row references per enumeration page (db-service caps it at 10,000) |
| workflowResources | object | `{"codeCacheMaxBytes":256000000,"codeMaxBytes":20000000,"codeMaxRows":100000,"codeTotalMaxBytes":40000000,"contextMaxChars":200000,"valueMaxBytes":262144}` | Workflow resources bound into operator runs and rendered into prompts. |
| workflowResources.codeCacheMaxBytes | int | `256000000` | Byte budget for the worker's per-process cache of materialized code resources |
| workflowResources.codeMaxBytes | int | `20000000` | Ceiling on a single code operator's returned resource, in bytes |
| workflowResources.codeMaxRows | int | `100000` | Ceiling on the rows a single code operator may return |
| workflowResources.codeTotalMaxBytes | int | `40000000` | Ceiling on all code operator resources for one run, in bytes |
| workflowResources.contextMaxChars | int | `200000` | Ceiling on the resource context rendered into one prompt, in characters |
| workflowResources.valueMaxBytes | int | `262144` | Ceiling on a value resource's serialized inline value, in bytes |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
