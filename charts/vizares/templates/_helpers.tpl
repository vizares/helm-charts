{{/*
Expand the name of the chart.
*/}}
{{- define "vizares.name" -}}
{{- default .Chart.Name .Values.vizaresCE.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "vizares.namespace" -}}
{{- .Release.Namespace -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vizares.fullname" -}}
{{- if .Values.vizaresCE.fullnameOverride }}
{{- .Values.vizaresCE.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.vizaresCE.nameOverride }}
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
{{- define "vizares.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vizares.labels" -}}
helm.sh/chart: {{ include "vizares.chart" . }}
{{ include "vizares.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vizares.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vizares.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vizares.serviceAccountName" -}}
{{- if .Values.vizaresCE.serviceAccount.create }}
{{- default (include "vizares.fullname" .) .Values.vizaresCE.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.vizaresCE.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Vizares Connect
*/}}
{{- define "vizaresConnect.name" -}}
{{- printf "%s-connect" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "vizaresConnect.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vizaresConnect.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "vizaresConnect.labels" -}}
helm.sh/chart: {{ include "vizares.chart" . }}
{{ include "vizaresConnect.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.vizaresConnect.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Vizares Cluster Agent
*/}}
{{- define "vizaresClusterAgent.name" -}}
{{- if .Values.vizaresClusterAgent.fullnameOverride -}}
{{- .Values.vizaresClusterAgent.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-cluster-agent" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- define "vizaresClusterAgent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vizaresClusterAgent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "vizaresClusterAgent.labels" -}}
helm.sh/chart: {{ include "vizares.chart" . }}
{{ include "vizaresClusterAgent.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.vizaresClusterAgent.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create a fully qualified Prometheus server name
in a similar way as prometheus/templates/_helpers.tpl creates "prometheus.server.fullname".
*/}}
{{- define "vizares.prometheus.server.fullname" -}}
{{- if .Values.prometheus.server.fullnameOverride -}}
{{- .Values.prometheus.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-prometheus-%s" .Release.Name .Values.prometheus.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified Clickhouse name.
*/}}
{{- define "vizares.clickhouse.fullname" -}}
{{- if .Values.clickhouse.fullnameOverride }}
{{- .Values.clickhouse.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-clickhouse" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
