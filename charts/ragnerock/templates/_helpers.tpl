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
{{- end }}
