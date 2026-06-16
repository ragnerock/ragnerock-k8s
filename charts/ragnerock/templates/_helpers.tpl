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
Usage: {{ include "ragnerock.image" (dict "global" .Values.global "image" .Values.api.image) }}
*/}}
{{- define "ragnerock.image" -}}
{{- $tag := .image.tag | default .global.image.tag -}}
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
{{- end }}
