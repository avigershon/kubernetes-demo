{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rest-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rest-proxy.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rest-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified zookeeper name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rest-proxy.zookeeper.fullname" -}}
{{- $name := default "zookeeper" (index .Values "zookeeper" "nameOverride") -}}
{{- printf "%s-%s-headless" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Form the Zookeeper URL. If zookeeper is installed as part of this chart, use k8s service discovery,
else use user-provided URL
*/}}
{{- define "rest-proxy.zookeeper.service-name" }}
{{- if (index .Values "zookeeper" "url") -}}
{{- printf "%s" (index .Values "zookeeper" "url") }}
{{- else -}}
{{- printf "%s:2181" (include "rest-proxy.zookeeper.fullname" .) }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified schema registry name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "rest-proxy.schema-registry.fullname" -}}
{{- $name := default "schema-registry" (index .Values "schema-registry" "nameOverride") -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "rest-proxy.schema-registry.service-name" -}}
{{- if (index .Values "schema-registry" "url") -}}
{{- printf "%s" (index .Values "schema-registry" "url") -}}
{{- else -}}
{{- printf "http://%s:8081" (include "rest-proxy.schema-registry.fullname" .) -}}
{{- end -}}
{{- end -}}
