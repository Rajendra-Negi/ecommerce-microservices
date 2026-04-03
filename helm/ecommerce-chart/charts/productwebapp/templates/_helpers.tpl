{{/*
Expand the name of the chart.
*/}}
{{- define "productwebapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fullname using release name and chart name.
*/}}
{{- define "productwebapp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "productwebapp.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
