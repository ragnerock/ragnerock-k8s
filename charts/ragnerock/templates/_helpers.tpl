{{/*
Expand the name of the chart.
*/}}
{{- define "ragnerock.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "ragnerock.fullname" -}}
  {{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ragnerock.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "ragnerock.labels" -}}
helm.sh/chart: {{ include "ragnerock.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for a given component.
Usage: {{ include "ragnerock.selectorLabels" (dict "context" . "component" "api") }}
*/}}
{{- define "ragnerock.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ragnerock.name" .context }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{/*
Render a number as plain decimal.
Usage: {{ include "ragnerock.number" .Values.audit.queueMaxBytes }}

Helm parses YAML numbers into float64, and Go renders large float64 values in
scientific notation ("1.34217728e+08"), which downstream services reject when
parsing the value as an integer. Whole numbers are emitted as integers here;
fractional values and strings pass through unchanged.
*/}}
{{- define "ragnerock.number" -}}
  {{- if kindIs "float64" . -}}
    {{- if eq . (floor .) -}}
      {{- printf "%d" (int64 .) -}}
    {{- else -}}
      {{- printf "%v" . -}}
    {{- end -}}
  {{- else -}}
    {{- printf "%v" . -}}
  {{- end -}}
{{- end }}

{{/*
Render an image reference.
Usage: {{ include "ragnerock.image" (dict "global" .Values.global "image" .Values.api.image "chart" .Chart) }}
Tag resolution order: per-service image.tag, then global.image.tag, then the chart's appVersion.
*/}}
{{- define "ragnerock.image" -}}
  {{- $tag := .image.tag | default .global.image.tag | default .chart.AppVersion -}}
  {{- printf "%s/%s:%s" .global.image.registry .image.name $tag -}}
{{- end }}

{{/*
Resolve a secret name. When an existing secret name is provided it is used as-is
(for secrets provisioned outside the chart); otherwise the chart-generated name is returned.
Usage: {{ include "ragnerock.secretName" (dict "context" . "suffix" "db" "existingSecret" .Values.database.existingSecret) }}
*/}}
{{- define "ragnerock.secretName" -}}
  {{- if .existingSecret -}}
{{- .existingSecret -}}
  {{- else -}}
    {{- printf "%s-%s" (include "ragnerock.fullname" .context) .suffix -}}
  {{- end -}}
{{- end -}}

{{/*
Build WEB_FETCH_BLOCKLIST: the hosts a model-chosen URL must never reach.

"Public address" is not the same as "not reachable from here" — this release's
own Services answer any pod in the cluster, and a public name in front of the
API answers the internet. Both are seeded here so a search result cannot talk
the model into fetching from the deployment itself; `webTools.fetchBlocklistExtra`
is where an operator adds partner APIs that trust this cluster's egress address.
Usage: {{ include "ragnerock.webFetchBlocklist" . }}
*/}}
{{- define "ragnerock.webFetchBlocklist" -}}
  {{- $fullname := include "ragnerock.fullname" . -}}
  {{- $services := list "api" "worker" "subtask-worker" "model-service" "analysis-toolkit" "python-service" "frontend" "data-ingestor" "callback-delivery" "db-service" "audit-service" -}}
  {{- $hosts := list -}}
  {{- /* Every spelling an in-cluster name has: the bare Service name, the
  namespace-qualified forms, and the cluster FQDN. The blocklist
  matches hostnames exactly, so one spelling would leave the others
  reachable. */ -}}
  {{- range $services -}}
    {{- $svc := printf "%s-%s" $fullname . -}}
    {{- $hosts = append $hosts $svc -}}
    {{- $hosts = append $hosts (printf "%s.%s" $svc $.Release.Namespace) -}}
    {{- $hosts = append $hosts (printf "%s.%s.svc" $svc $.Release.Namespace) -}}
    {{- $hosts = append $hosts (printf "%s.%s.svc.cluster.local" $svc $.Release.Namespace) -}}
  {{- end -}}
  {{- $hosts = concat $hosts .Values.webTools.fetchBlocklistExtra -}}
  {{- join "," $hosts -}}
{{- end }}

{{/*
Render a HorizontalPodAutoscaler for a component.
Usage: {{ include "ragnerock.hpa" (dict "context" $ "component" "api" "values" .Values.api) }}
The component's values must contain an `autoscaling` block. Caller is
responsible for checking `autoscaling.enabled`.
*/}}
{{- define "ragnerock.hpa" -}}
  {{- $ctx := .context -}}
  {{- $component := .component -}}
  {{- $autoscaling := .values.autoscaling -}}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "ragnerock.fullname" $ctx }}-{{ $component }}
  labels:
    {{- include "ragnerock.labels" $ctx | nindent 4 }}
    {{- include "ragnerock.selectorLabels" (dict "context" $ctx "component" $component) | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "ragnerock.fullname" $ctx }}-{{ $component }}
  minReplicas: {{ $autoscaling.minReplicas }}
  maxReplicas: {{ $autoscaling.maxReplicas }}
  metrics:
  {{- with $autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ . }}
  {{- end }}
  {{- with $autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ . }}
  {{- end }}
{{- end }}

{{/*
Render a PodDisruptionBudget for a component.
Usage: {{ include "ragnerock.pdb" (dict "context" $ "component" "worker" "values" .Values.worker) }}
The component's values must contain a `podDisruptionBudget` block with exactly
one of `minAvailable`/`maxUnavailable` set. Caller is responsible for checking
`podDisruptionBudget.enabled`.
*/}}
{{- define "ragnerock.pdb" -}}
  {{- $ctx := .context -}}
  {{- $component := .component -}}
  {{- $pdb := .values.podDisruptionBudget -}}
  {{- $min := $pdb.minAvailable -}}
  {{- $max := $pdb.maxUnavailable -}}
  {{- $hasMin := not (kindIs "invalid" $min) -}}
  {{- $hasMax := not (kindIs "invalid" $max) -}}
  {{- if and $hasMin $hasMax -}}
    {{- fail (printf "%s.podDisruptionBudget: set only one of minAvailable or maxUnavailable" $component) -}}
  {{- end -}}
  {{- if not (or $hasMin $hasMax) -}}
    {{- fail (printf "%s.podDisruptionBudget: one of minAvailable or maxUnavailable must be set when enabled" $component) -}}
  {{- end -}}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ include "ragnerock.fullname" $ctx }}-{{ $component }}
  labels:
    {{- include "ragnerock.labels" $ctx | nindent 4 }}
    {{- include "ragnerock.selectorLabels" (dict "context" $ctx "component" $component) | nindent 4 }}
spec:
  {{- if $hasMin }}
  minAvailable: {{ $min }}
  {{- end }}
  {{- if $hasMax }}
  maxUnavailable: {{ $max }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "ragnerock.selectorLabels" (dict "context" $ctx "component" $component) | nindent 6 }}
{{- end }}

{{/*
Resolve the ServiceAccount name to use for a component's pods.
Returns the explicitly configured name, or a generated name when `create` is
true, or an empty string to fall back to the namespace default ServiceAccount.
Usage: {{ include "ragnerock.serviceAccountName" (dict "context" . "config" .Values.api.serviceAccount "component" "api") }}
*/}}
{{- define "ragnerock.serviceAccountName" -}}
  {{- if .config.name -}}
{{- .config.name -}}
  {{- else if .config.create -}}
    {{- printf "%s-%s" (include "ragnerock.fullname" .context) .component -}}
  {{- end -}}
{{- end -}}

{{/*
OpenTelemetry service-identity env vars for a component.
servicePrefix is applied to BOTH service.name (in OTEL_RESOURCE_ATTRIBUTES) and
OTEL_SERVICE_NAME so they never disagree — per the OTEL spec OTEL_SERVICE_NAME
overrides service.name from OTEL_RESOURCE_ATTRIBUTES, so both must carry the
prefix for servicePrefix to take effect.
Usage: {{ include "ragnerock.otelEnv" (dict "context" . "service" "db-service") | nindent 12 }}
*/}}
{{- define "ragnerock.otelEnv" -}}
  {{- $otel := .context.Values.otel -}}
  {{- $name := printf "%s%s" $otel.servicePrefix .service -}}
- name: OTEL_RESOURCE_ATTRIBUTES
  value: service.namespace={{ $otel.serviceNamespace }},service.name={{ $name }},deployment.environment={{ .context.Values.config.environmentIdentifier }}
- name: OTEL_SERVICE_NAME
  value: {{ $name }}
{{- end -}}

{{/*
Merge global and per-service annotations into a single set of key/value pairs.
Per-service keys (`<service>.annotations`) take precedence over `global.annotations`.
Renders the annotation lines only (no `annotations:` header) so callers can nest
them under an existing `metadata.annotations` block; renders nothing when empty.
Usage: {{ include "ragnerock.annotations" (dict "context" . "config" .Values.api) }}
*/}}
{{- define "ragnerock.annotations" -}}
  {{- $global := .context.Values.global.annotations | default dict -}}
  {{- $service := .config.annotations | default dict -}}
  {{- $merged := merge (deepCopy $service) $global -}}
  {{- with $merged -}}
{{ toYaml . }}
  {{- end -}}
{{- end -}}

{{/*
The worker's connection pool size: explicit when set, otherwise derived the way
the worker derives it for itself -- one connection per possible in-flight
handler plus headroom for non-request work, with the in-flight count capped by
the per-instance request concurrency, because a process cannot run more
handlers than it admits.

Defined once and used by both the worker ConfigMap and the connection budget
below, so the number a worker receives and the number the budget sums cannot
drift apart.
*/}}
{{- define "ragnerock.workerPoolSize" -}}
  {{- if .Values.workers.database.poolSize -}}
{{- .Values.workers.database.poolSize -}}
  {{- else -}}
    {{- $inFlight := add .Values.limits.concurrency.maxConcurrentSubtasks .Values.limits.concurrency.maxConcurrentJobs .Values.workers.maxConcurrentJobAdvances .Values.workers.maxConcurrentSpawns -}}
    {{- if .Values.workers.maxInstanceRequestConcurrency -}}
      {{- $inFlight = min $inFlight (int .Values.workers.maxInstanceRequestConcurrency) -}}
    {{- end -}}
{{- add $inFlight .Values.workers.database.poolHeadroom -}}
  {{- end -}}
{{- end -}}

{{/*
The worker's overflow: explicit when set, otherwise the pool headroom.
*/}}
{{- define "ragnerock.workerMaxOverflow" -}}
{{- .Values.workers.database.maxOverflow | default .Values.workers.database.poolHeadroom -}}
{{- end -}}

{{/*
The SUBTASK worker's pool, which is a different number from the plain worker's.

They share the limits ConfigMap because they run the same image, but they do not
serve the same work: at concurrency 1 the plain worker never runs a subtask, so a
pool sized for MAX_CONCURRENT_SUBTASKS is one it holds open for nothing. The
derivation cannot tell them apart -- it sums every in-flight limit either could
serve -- so the split has to be a value. Falls back to the shared pool, which is
what every existing install already renders.
*/}}
{{- define "ragnerock.subtaskWorkerPoolSize" -}}
  {{- if .Values.workers.database.subtaskPoolSize -}}
{{- .Values.workers.database.subtaskPoolSize -}}
  {{- else -}}
{{- include "ragnerock.workerPoolSize" . -}}
  {{- end -}}
{{- end -}}

{{/*
The subtask worker's overflow, falling back to the shared one.
*/}}
{{- define "ragnerock.subtaskWorkerMaxOverflow" -}}
  {{- if .Values.workers.database.subtaskMaxOverflow -}}
{{- .Values.workers.database.subtaskMaxOverflow -}}
  {{- else -}}
{{- include "ragnerock.workerMaxOverflow" . -}}
  {{- end -}}
{{- end -}}

{{/*
Worst-case replicas for a component: the autoscaler's ceiling when it is
managing the count, otherwise the fixed replica count. The budget has to sum
the ceiling -- a pool is only "small" until the autoscaler decides otherwise.

Call as: include "ragnerock.maxReplicas" .Values.api
*/}}
{{- define "ragnerock.maxReplicas" -}}
  {{- if and .autoscaling .autoscaling.enabled -}}
{{- .autoscaling.maxReplicas -}}
  {{- else -}}
{{- .replicaCount | default 1 -}}
  {{- end -}}
{{- end -}}

{{/*
The API's request gate against the pool it is sized from.

The coherence rule the connection budget rests on: an ordinary API request
holds a connection for most of its life, so admitting more of them than the
pool can serve does not buy throughput -- the excess waits on `pool_timeout`,
and Kubernetes has no platform concurrency in front to shed first. On GCP a
Terraform precondition checks the same relationship against Cloud Run's
per-instance concurrency; that check does not run for this chart, which is
exactly why this one exists.

Stream slots are deliberately not counted: a streaming route releases its
session before the response body starts, so it costs a slot and no connection.
*/}}
{{- define "ragnerock.apiGateFitsPool" -}}
  {{- $capacity := add .Values.database.poolSize .Values.database.maxOverflow -}}
  {{- if gt (int .Values.api.maxConcurrentRequests) (int $capacity) -}}
    {{- fail (printf "api.maxConcurrentRequests is %d but one API pod can hold only %d connections (database.poolSize %d + maxOverflow %d). Every admitted request in this class holds one for most of its life, so the excess queues on poolTimeout instead of being shed with a Retry-After. Lower the gate or raise the pool -- and if you raise the pool, re-check database.maxConnections." (int .Values.api.maxConcurrentRequests) (int $capacity) (int .Values.database.poolSize) (int .Values.database.maxOverflow)) -}}
  {{- end -}}
{{- end -}}

{{/*
Cloud SQL connection budget.

Every service here is a single process with one synchronous engine, so its
worst case is replicas x (poolSize + maxOverflow). Summed across the chart that
number has to stay under what the server will actually hand out, or overload
surfaces as `FATAL: remaining connection slots are reserved` on whichever
service happens to ask next -- not necessarily the one that caused it.

Inert unless `database.maxConnections` is set, because a chart installed
against someone else's Postgres cannot know the ceiling. Setting it replaces
the hand-maintained arithmetic that used to live in a comment.
*/}}
{{- define "ragnerock.connectionBudget" -}}
  {{- if .Values.database.maxConnections -}}
    {{- $workerPool := int (include "ragnerock.workerPoolSize" .) -}}
    {{- $workerOverflow := int (include "ragnerock.workerMaxOverflow" .) -}}
    {{- $workerConns := add $workerPool $workerOverflow -}}
    {{- $demand := 0 -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.api)) (add .Values.database.poolSize .Values.database.maxOverflow)) -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.worker)) $workerConns) -}}
    {{- $subtaskPool := int (include "ragnerock.subtaskWorkerPoolSize" .) -}}
    {{- $subtaskOverflow := int (include "ragnerock.subtaskWorkerMaxOverflow" .) -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.subtaskWorker)) (add $subtaskPool $subtaskOverflow)) -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.dbService)) (add .Values.dbService.defaultDBPoolSize .Values.dbService.defaultDBMaxOverflow)) -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.auditService)) (add .Values.auditService.database.poolSize .Values.auditService.database.maxOverflow)) -}}
    {{- $demand = add $demand (mul (int (include "ragnerock.maxReplicas" .Values.callbackDelivery)) (add .Values.callbackDelivery.database.poolSize .Values.callbackDelivery.database.maxOverflow)) -}}
    {{- $budget := sub (int .Values.database.maxConnections) (add (int .Values.database.reservedConnections) (int .Values.database.opsConnectionHeadroom)) -}}
    {{- if gt $demand $budget -}}
      {{- fail (printf "Worst-case DB connection demand is %d, over the %d available (database.maxConnections %d less %d reserved and %d for operators). Shrink pools or replica ceilings, or raise database.maxConnections." $demand $budget (int .Values.database.maxConnections) (int .Values.database.reservedConnections) (int .Values.database.opsConnectionHeadroom)) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
