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
