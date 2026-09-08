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
