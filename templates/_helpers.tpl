{{/*
Expand the name of the chart.
*/}}
{{- define "arma3.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "arma3.fullname" -}}
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
{{- define "arma3.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "arma3.labels" -}}
helm.sh/chart: {{ include "arma3.chart" . }}
{{ include "arma3.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "arma3.selectorLabels" -}}
app.kubernetes.io/name: {{ include "arma3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "arma3.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "arma3.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "credentials.useExistingSecretNamespace" }}
{{- if .Values.credentials.useExistingSecret.namespace }}
{{ .Values.credentials.useExistingSecret.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}

{{- define "credentials.useExistingSecretName" }}
{{- if .Values.credentials.useExistingSecret.name }}
{{- .Values.credentials.useExistingSecret.name }}
{{- else }}
{{- .Release.Name }}
{{- end }}
{{- end }}

{{- define "serverPassword" -}}
{{- $content := (lookup "v1" "Secret" (include "credentials.useExistingSecretNamespace" .) (include "credentials.useExistingSecretName" .) ) }}
{{- if .Values.credentials.serverPassword -}}
{{ .Values.credentials.serverPassword }}
{{- else if $content -}}
{{ (index $content.data .Values.credentials.useExistingSecret.serverPasswordKey) | b64dec -}}
{{- else -}}
noLookupWhenTemplating
{{- end -}}
{{- end -}}

{{- define "adminPassword" -}}
{{- $content := (lookup "v1" "Secret" (include "credentials.useExistingSecretNamespace" .) (include "credentials.useExistingSecretName" .) ) }}
{{- if .Values.credentials.adminPassword -}}
{{ .Values.credentials.adminPassword }}
{{- else if $content -}}
{{ (index $content.data .Values.credentials.useExistingSecret.adminPasswordKey) | b64dec -}}
{{- else -}}
noLookupWhenTemplating
{{- end -}}
{{- end -}}

{{- define "steamUser" -}}
{{- $content := (lookup "v1" "Secret" (include "credentials.useExistingSecretNamespace" .) (include "credentials.useExistingSecretName" .) ) }}
{{- if .Values.credentials.steamUser -}}
{{ .Values.credentials.steamUser }}
{{- else if $content -}}
{{ (index $content.data .Values.credentials.useExistingSecret.steamUserKey) | b64dec -}}
{{- else -}}
noLookupWhenTemplating
{{- end -}}
{{- end -}}

{{- define "steamPassword" -}}
{{- $content := (lookup "v1" "Secret" (include "credentials.useExistingSecretNamespace" .) (include "credentials.useExistingSecretName" .) ) }}
{{- if .Values.credentials.steamPassword -}}
{{ .Values.credentials.steamPassword }}
{{- else if $content -}}
{{ (index $content.data .Values.credentials.useExistingSecret.steamPasswordKey) | b64dec -}}
{{- else -}}
noLookupWhenTemplating
{{- end -}}
{{- end -}}

{{- define "rsyncEnabled" -}}
{{- if and .Values.rsync.enabled (not .Values.persistence.headlessclient.sharedFilesystem) }}
true
{{- else -}}

{{- end -}}
{{- end -}}