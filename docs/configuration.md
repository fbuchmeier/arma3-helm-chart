# arma-3 Kubernetes Deployment

## Enable Console

## Commands


## Updating AntiStasi MP Missions

1. Copy update script into container (if not yet present)

  ```
  kubectl cp -n game-servers update-antistasi.bash $(kubectl get pods -n game-servers -l app=arma3 -o json | jq -r '.items[].metadata.name'):/arma3/mpmissions/update-antistasi.bash
  ```

1. Execute update

  ```
  kubectl exec -it -n game-servers $(kubectl get pods -n game-servers -l app=arma3 -o json | jq -r '.items[].metadata.name') -- bash /arma3/mpmissions/update-antistasi.bash 2.5.4
  ```

## Applying Profiles / AntiStasi Saves

1. Stop ARMA3

  ```
  kubectl scale deploy -n game-servers arma3 --replicas=0
  ```

1. Start the filemanager pod

  ```
  kubectl apply -f examples/longhorn-filemanager-arma3.yaml`
  ```

1. Copy your profile into the container:

  ```
  kubectl cp /media/data/scratch/share/Florian.vars.Arma3Profile -n game-servers filemanager:/data/configs/profiles/home/main/main.vars.Arma3Profile
  ```

1. Delete the filemanager pod

  ```
  kubectl delete -f examples/longhorn-filemanager-arma3.yaml
  ```

1. Start ARMA3:

  ```
  kubectl scale deploy -n game-servers arma3 --replicas=1
  ```

## Using Headless Clients

Headless clients (as of now `hc`) can be added by setting `headlessclient.replicas` to a non-zero value. There are different storage approaches you can take for the headless clients, each with it's on pros and cons:

### Server and Headless Clients sharing the same ReadWriteMany Filesystem

This can be achieved by setting:

- `persistence.headlessclient.sharedFilesystem` to `true`
- `persistence.server.accessMode` to `ReadWriteMany`

Any settings under the `rsync` key will be ignored and rsync will be disabled on both the server and the hc.

This will provision a single PVC and PV that is shared between the server and _all_ headless clients.

NOTE: The headless clients will restart (Crashloop) until all the inital game data has been downloaded by the server. They currently do not wait for the installation to complete before trying to start up.

Pros:

- easy configuration
- requires only one set of data and thus saves storage

Cons:

- requires a storage driver that supports ReadWriteMany volumes
- initial installation, downloading of huge mods or upgrades may require more time, as the data will be streamed to the server and then to the remove filesystem. 
- slower startup of the server as the networkfilesystem used for RWX access is not as fast as a local disk

In our tests using Longhorn (NFS) for RWX in a Lab environment (1GBit/s network) and wit around 50GB of mods, this approach was not stable due to the high network demands.

## Server with a dedicated ReadWriteOnce volume and Headless clients with a single ReadWriteMany volume

This can be achieved by setting:

- `persistence.server.accessMode` to `ReadWriteOnce`
- `persistence.headlessclient.accessMode` to `ReadWriteMany`
- `persistence.headlessclient.sharedFilesystem` to `false`
- `rsync.enabled` to `true`

This will provision a single PVC and PV with RWO for the server with usually fast and local storage and another PVC and PV pair for the headless clients with network storage (e.g. NFS). The server will initially download any game data, mods and updates and once it has finished, the first headless client will start up, connect to the rsyncd running in the server pod and download any new or updated data to the headless clients PVC. Once this is finished, the remaining hcs will start up automatically.

Pros:

- fast server startup as the server files are locally on NVMe disks.
- no network bottleneck
- only twice the amount of storage required in comparison to the last method

Cons:

- requires twice the storage in comparison to using a single RWX volume
- headless clients take some time to sync the data on initial installation or major updates, depending on the speed of the network

This approach worked well in our home lab and reduced the load on the network significantly.

## Server and each Headless client have their own dedicated ReadWriteOnce volume (Not yet implemented)

In this approach, each component has its own dedicated and local RWO volume. The server uses a predfined PVC and PV pair, the headless client a volume claim template which provisions new volumes for every replica in the StatefulSet.

This can be achieved by setting:

- `persistence.server.accessMode = ReadWriteOnce`
- `persistence.headlessclient.accessMode = ReadWriteOnce`
- `persistence.headlessclient.sharedFilesystem` to `false`
- `rsync.enabled` to either `true` (recommended) or `false`

Game data can either be downloaded from the internet directly for every component and replica (when `rsync.enabled = false`) or only once from the internet (the server, when `rsync.enabled = true`) and then replicated to the headless clients via rsync on startup.

In the case of for example 50GBs of game data and three (3) headless clients, the initial installation will:

- download 50GB from the internet on the server pod to the server PV
- either
  - download 50GB from the internet per headless client replica to each headless client over the internet
  - or replicate 50GB from the server per headless client over the local network

Setting `rsync.enabled = false` is not recommended in this scenario, unless you have a really good internet connection.

Pros:

- no network filesystem / RWX capable storage solution is required
- fast file access for all components due to local storage

Cons:

- the amount of required storage increases with the amount of headless clients provisioned
- volumes will remain present even after scaling down any headless clients
- initial setup will take quite some time and depends heavily either on your internet or local network speed

### Disallowed Configurations

- rsync.enabled = true AND sharedFilesystem = true
- rwo for server, rwo for clients and rsync.enabled = false (clients will have no game data)
- rwo for server, rwx for clients and rsync.enabled = false (clients will have no game data)
- rwx for server, rwo (server does not benefit from rwx when clients use rwo)
- sharedFilesystem = true AND rwo for server or client (will not work)

## Backing up profiles

```
kubectl cp -n game-servers $(kubectl get pods -n game-servers -l app=arma3 -o json | jq -r '.items[].metadata.name'):/data/configs/profiles/home/main/main.vars.Arma3Profile /media/data/scratch/share/main.vars.Arma3Profile-$(date +%F-%s)
```

## Mods

When reinstalling ARMA3, copy the referenced mod html into the container: 


```
 kubectl cp ~/arma3/unsung_redux.html -n game-servers arma3-6c5678d546-555qk:/arma3/unsung_redux.html
```