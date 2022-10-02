## Open Tasks

1. build a pipeline for the docker image (tekton) since [synixebrett/arma3server](https://hub.docker.com/r/synixebrett/arma3server/tags) has not been updated for one year
    1. publish the image to a public repo (dockerhub?)
    1. also build a pipeline for the rsync image

1. build a pipeline for the helm chart
    1. publish the chart to a public repo (github?)

1. add readyness probe:
    ```
    wget https://kubernetes.default/api/v1/namespaces/game-servers/pods/$HOSTNAME/log?sinceSeconds=5  --header "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" --no-check-certificate
    ```

    headlessclient: Connection with host has been lost -> fail
    server: `Host identity created` `Connected to Steam servers` -> success

1. BUG: https://steamcommunity.com/app/107410/discussions/1/611696927915628913/ copied files manually

1. connecting the headless clients to the kubernetes service fails because the pods have a random IP within the 10.42.0.0/16 range and no wildcards can be used in main.cfg

    ```
    -client -connect={{ include "arma3.fullname" . }} -password={{ include "serverPassword" . }}
    ```

1. lookup ippool from CustomResource and inject it into configMap, but only when corresponding pod annotation is set

    ```
    {{- $content := (lookup "v1" "ippool.crd.projectcalico.org" .Values.podAnnotations. (include "credentials.useExistingSecretName" .) ) }}
    ```
1. generate list of allowed headless clients from ippool <-- is this still required?

1. switch to maintained fork https://github.com/mylesagray/Arma3Server

1. add allow list to rsync-server

    ```
                # TODO: add allow list
    #            - name: ALLOW
    #              value: 192.168.8.0/24 192.168.24.0/24 172.16.0.0/12 127.0.0.1/3
    ```

1. use a longhorn backing image for base arma3 installation

1. reconnect headlessclient on server restart 
    `Connection with host has been lost.` is logged by the HC

1. When using `ReadWriteOnce` as access mode on headless client, require `rsync.enabled = true` and setup VolumeClaimTemplate instead of normal PVC

1. When using persistence.server.accessMode = ReadWriteMany and headlessclient.sharedFilesystem use the same PVC for server and headless clients (this disables rsync!)

1. Add configuration checks that alert on:

    - persistence.headlessclient.accessMode = ReadWriteOnce and headlessclient.replicas > 1
    - rsync.enabled = false and persistence.server.accessMode = ReadWriteOnce
    - 

1. Use busybox image (wget and tar) to setup missions, this saves some time on apt setup)

1. add livenessprobe to server and restart it automatically

1. add livenessprobe to headlessclient and restart it automatically

1. add documentation on how to:

    - contribute to the chart
    - install the chart
    - configure the chart (example configurations for different use cases)

1. run rsyncd and rsync-client as non-root (431:433) and without capabilities

1. when using an external secret, the configmap (server.cfg) does not get updated when the contents of the secret are update

    a manual upgrade is required to fetch the new values:

    ```
     helm upgrade --install -n game-servers arma3-baboon arma3-helm-chart/
    ```