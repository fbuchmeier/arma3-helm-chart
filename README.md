# arma3

![Version: 0.5.6](https://img.shields.io/badge/Version-0.5.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.2.0](https://img.shields.io/badge/AppVersion-2.2.0-informational?style=flat-square)

A Helm chart for [Arma 3](https://arma3.com/).

Requires:
  - an existing secret with credentials for Steam and the Server

Optional:
  - [stakater/reloader](https://github.com/stakater/Reloader) to trigger pod updates on config changes
  - [metallb](https://github.com/metallb/metallb) when hosting on bare-metal
  - a CSI driver that supports ReadWriteMany volumes (or plain NFS)

See [configuration](./docs/configuration.md) and [development](./docs/development.md) for more details.

This project uses the following components:

  - [Arma3Server Docker Image](https://github.com/fbuchmeier/Arma3Server)
  - [rsync-server Docker Image](https://github.com/fbuchmeier/rsync-server)
  - [Debian Bullseye Docker Image](https://github.com/docker-library/repo-info/blob/master/repos/debian/remote/bullseye.md)
  - [Common Utils](https://github.com/fbuchmeier/utils-docker)

Special thanks to:

  - [axiom-data-science](https://github.com/axiom-data-science) for their rsync-server docker image
  - [BrettMayson](https://github.com/BrettMayson) for his Arma 3 docker image

Development:

  - [helm-docs](https://github.com/norwoodj/helm-docs)
  - [kubeconform](https://github.com/yannh/kubeconform)
  - [yamllint](https://github.com/adrienverge/yamllint)
  - [rewrap](https://stkb.github.io/Rewrap/)
  - [markdownlint](https://github.com/markdownlint/markdownlint)
  - [convco](https://convco.github.io/)
  - [yq](https://github.com/mikefarah/yq)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Florian Buchmeier | <flo_buchmeier@web.de> | <https://github.com/fbuchmeier> |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| config.battleeye | int | `1` | 1=enabled, 0=disabled |
| config.env | object | `{"ARMA_CDLC":"","ARMA_LIMITFPS":"60","MODS_PRESET":"","STEAM_BRANCH":""}` | Environment parameters for the game container |
| config.env.ARMA_CDLC | string | `""` | Specify a creators DLC, e.g. 'vn' |
| config.env.ARMA_LIMITFPS | string | `"60"` | Specify the FPS limit for the server |
| config.env.MODS_PRESET | string | `""` | Use a preset from /modpresets/<presetname> |
| config.env.STEAM_BRANCH | string | `""` | Select the steam branch, e.g. 'creatordlc' |
| config.headlessClients | list | `[]` | Set the headlessClients and localClient, set to 127.0.0.1 whe .Values.headlessclient.enabled |
| config.hostname | string | `"arma3.example.com"` | External Hostname of server |
| credentials | object | `{"adminPassword":"","serverPassword":"","steamPassword":"","steamUser":"","useExistingSecret":{"adminPasswordKey":"admin-password","enabled":true,"name":"","namespace":"","serverPasswordKey":"server-password","steamPasswordKey":"steam-password","steamUserKey":"steam-user"}}` | Specify credentials for the server |
| credentials.useExistingSecret.adminPasswordKey | string | `"admin-password"` | The Server ADMIN Password |
| credentials.useExistingSecret.enabled | bool | `true` | Use a dedicated, already existing secret for credentials, any key already specified under 'credentials.' directly will be ignored |
| credentials.useExistingSecret.name | string | `""` | The credential is looked up from a secret with this name |
| credentials.useExistingSecret.namespace | string | `""` | The credential is looked up from a secret, which resides in this namespace if empty, use Release.Namespace |
| credentials.useExistingSecret.serverPasswordKey | string | `"server-password"` | The Server Password |
| credentials.useExistingSecret.steamPasswordKey | string | `"steam-password"` | The Steam API to Login to the Steam API |
| credentials.useExistingSecret.steamUserKey | string | `"steam-user"` | The Steam User to Login to the Steam API |
| deploymentAnnotations."reloader.stakater.com/auto" | string | `"true"` | To automatically reload the container on configuration changes, use |
| fullnameOverride | string | `""` |  |
| headlessclient | object | `{"affinity":{},"antiAffinity":{"enabled":true},"enabled":true,"initResources":{},"name":"hc","nodeSelector":{},"replicas":null,"resources":{},"tolerations":[]}` | Headless clients only work when persistence.data.accessMode is set to 'ReadWriteMany' |
| headlessclient.antiAffinity.enabled | bool | `true` | Enable podAntiAffinity so that server and headless clients get scheduled on different nodes if possible |
| headlessclient.initResources | object | `{}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user. |
| headlessclient.replicas | string | `nil` | Launch the given number of headless clients in separate pods |
| headlessclient.resources | object | `{}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user. |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"fbuchmeier/arma3server"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| missions.antistasi.version | string | `"2.5.5"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.annotations | object | `{}` |  |
| persistence.data.enabled | bool | `false` |  |
| persistence.data.size | string | `"40Gi"` |  |
| persistence.headlessclient.accessMode | string | `"ReadWriteOnce"` | Volume access mode, if you want to use more than one headless client, this must be ReadWriteMany |
| persistence.headlessclient.annotations | object | `{}` |  |
| persistence.headlessclient.enabled | bool | `false` | enable persistence for ARMA3 Headless Client data (all game assets except the config/profiles/main) |
| persistence.headlessclient.sharedFilesystem | bool | `false` | use the same filesystem for both the server and the headless clients |
| persistence.headlessclient.size | string | `"40Gi"` |  |
| persistence.profile.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.profile.annotations | object | `{}` |  |
| persistence.profile.enabled | bool | `true` | WARNING: if you set this to false, your progress in Antistasi will be lost on a server restart |
| persistence.profile.size | string | `"2Gi"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `433` |  |
| replicas | int | `1` | Only one replica is supported, set this to _any_ number to let helm control the replicas |
| resources | object | `{}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user. |
| rsync.enabled | bool | `true` | Use rsync to synchronize the game data from the server to the headless clients on startup |
| rsync.image.pullPolicy | string | `"IfNotPresent"` |  |
| rsync.image.repository | string | `"fbuchmeier/rsync-server"` |  |
| rsync.image.tag | string | `"2.0.1"` | Overrides the image tag whose default is the chart appVersion. |
| rsync.resources | object | `{}` |  |
| rsync.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| rsync.securityContext.runAsGroup | int | `0` |  |
| rsync.securityContext.runAsNonRoot | bool | `false` |  |
| rsync.securityContext.runAsUser | int | `0` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsGroup | int | `433` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `431` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| serviceMonitor.enabled | bool | `false` | - If true, a ServiceMonitor CRD is created for a prometheus operator |
| serviceMonitor.interval | string | `"5s"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.path | string | `"/metrics"` |  |
| serviceMonitor.relabelings | list | `[]` |  |
| serviceMonitor.scheme | string | `"http"` |  |
| serviceMonitor.scrapeTimeout | string | `"2s"` |  |
| tolerations | list | `[]` |  |
| tunnel | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"envoyproxy/envoy","tag":"v1.24-latest"},"resources":{}}` | Use envoy to tunnel requests from headless clients and whitelist only 127.0.0.1, automatically enabled with .Values.headlessclient.enabled |
| tunnel.image.tag | string | `"v1.24-latest"` | Overrides the image tag whose default is the chart appVersion. |
| tunnel.resources | object | `{}` | We usually recommend not to specify default resources and to leave this as a conscious choice for the user. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
