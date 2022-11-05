# ARMA3 HC Benchmarks

## Test Setup

Test date: 2022-10-31 Test version: latest ARMA3 stable release as of this date

Tests were executed with the [Headless Client/Server Performance
Benchmark](https://steamcommunity.com/sharedfiles/filedetails/?id=495281158&insidemodal=0&requirelogin=1)

All tests were run with only one (1) player connected.

All tests were performed with Docker containers running in Kubernetes 1.23 using
Calico CNI.

*Node 1 (192.168.178.34):*

- CPU: AMD Ryzen 7 2700
  - Threads: 16
- Memory:
  - Speed: 2667 MT/s
  - Size: 2x 16GB
- Software
  - Ubuntu 18.04
  - Linux 4.15.0-194-generic #205-Ubuntu SMP Fri Sep 16 19:49:27 UTC 2022 x86_64
    x86_64 x86_64 GNU/Linux
  - Docker 20.10.20

*Node 2 (192.168.178.35):*

- CPU: AMD Ryzen 5 5600G
  - Threads: 12
- Memory:
  - Speed: 3200 MT/s
  - Size: 2x 16GB
- Software
  - Ubuntu 22.04
  - Linux 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64
    x86_64 x86_64 GNU/Linux
  - Docker 20.10.20

## Mods

See [./mods.html](./mods.html)

## Single Server Only (node 1)

Node 1: Server (R7 2700)

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/yeyNWUb0jHe4b8c6ORzpKu6YOpDYe7A7)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667253180000&to=1667253300000)
  - Start: 22:53
  - Finish: 22:55

## Server and HC spread across two dedicated nodes

### Server (nodes 1) + 1 HC (node 2)

Server and HC running on dedicated machines within the same 1GBit/s LAN.

Node 1: Server (R7 2700)

Node 2: 1 HC (R5 5600G)

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/YBfjcUoMlyVVff9MtBkO7wdqE1oFH1k0)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667253960000&to=1667254080000)
  - Start: 23:06
  - Finish: 23:08

### Server + 4 HC

Node 1: Server + 2 HCs (R7 2700)

Node 2: 2 HCs (R5 5600G)

Server and HC running on dedicated machines within the same 1GBit/s LAN.

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/BG6ih9EGIV00Fqb4jtGEyOuIus1YqFEF)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667255280000&to=1667255400000)
  - Start: 23:28
  - Finish: 23:30

- [run
  2](https://snapshots.raintank.io/dashboard/snapshot/QJsg3aHITyeWJgV1wJMJ4nc4E07sp3bF)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667255700000&to=1667255820000)
  - Start: 23:35
  - Finish: 23:37

## Server and HC running on the same node (node 1)

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/VGcQxKjX15MfxJMFAIBhBLJcstLXYUWu)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667256780000&to=1667256900000)
  - Start: 23:53
  - Finish: 23:55

- [run
  2](https://snapshots.raintank.io/dashboard/snapshot/qIiaWJkWNGMX0kzgzGA3Az9BejEypz4V)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667257080000&to=1667257200000)
  - Start: 23:58
  - Finish: 00:00

## Single Server (node 2)

Server: node 2 (R5 5600G)

Frequency and IPC scaling.

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/O6t5IsFO138kg1Y2FkR9deF05qU509K9)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667258640000&to=1667258760000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All&var-instance=192.168.178.35:9100)
  - Start: 00:24
  - Finish: 00:26

- [run
  2](https://snapshots.raintank.io/dashboard/snapshot/uW4fyM42UiYpGsvZeGsYtvKR4uhHneHT)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667258940000&to=1667259060000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All&var-instance=192.168.178.35:9100)
  - Start: 00:29
  - Finish: 00:31

## Server and HC running on the same node (node 2)

Server: node 2 (R5 5600G)

HC: node 2 (R5 5600G)

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/RxnG98bUcewTWPdN7OOinYiRWszgcxab)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&from=1667259360000&to=1667259480000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All&var-instance=192.168.178.35:9100)
  - Start: 00:36
  - Finish: 00:38

## Server and HC running on different nodes

Server: node 2 (R5 5600G)

HC: node 1 (R7 2700)

- [run
  1](https://snapshots.raintank.io/dashboard/snapshot/TOEkQSL5Uotb62NJLKIKF9tM9uzNF6As)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&https:%2F%2Fgrafana.beliar.eu%2Fd%2FABPrs_N4k%2Farma3%3ForgId=1&from=1667259900000&to=1667260020000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All)
  - Start: 00:45
  - Finish: 00:47

- [run
  2](https://snapshots.raintank.io/dashboard/snapshot/F3FUCOethJbXAL9HVuRJS7G1zKk3E1Bg)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&https:%2F%2Fgrafana.beliar.eu%2Fd%2FABPrs_N4k%2Farma3%3ForgId=1&from=1667260260000&to=1667260380000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All)
  - Start: 00:51
  - Finish: 00:53

- [run
  3](https://snapshots.raintank.io/dashboard/snapshot/6nZytMnuRPJLCYt1gfhhQsgatHqvwoWJ)
  - [private
    link](https://grafana.beliar.eu/d/ABPrs_N4k/arma3?orgId=1&https:%2F%2Fgrafana.beliar.eu%2Fd%2FABPrs_N4k%2Farma3%3ForgId=1&from=1667260620000&to=1667260740000&var-datasource=Prometheus&var-cluster=&var-namespace=game-servers&var-pod=All)
  - Start: 00:57
  - Finish: 00:59

## Summary

- Running the dedicated server and headless client on the same machine is faster
  than without headless clients XX.
- Using two different nodes for server and headless client improves performance
  by XX.
- Running more than one headless client has only marginal benefits (XX) in this
  scenario  but consumes much more CPU (XX) and Memory (XX) than a single HC.
- When different CPU speeds are in play, running the dedicated server on the
  fastest single threaded CPU (here: 5600G) is recommended. Headless clients do
  not benefit as much from faster CPUs (diff to the other way round XX).

Bonus: Running the dedicate server and a single HC on a Ryzen 7 5900X is still
faster and more efficient than using two different nodes and multiple HCs.

## Antistasi

Additional benchmarks were run with a game of Antistasi in Cam Lao  Nam.

Server performance increases slightly when going from no HC to 1 HC (less than 10% in average FPS), but CPU and memory usage double. When going from 0 to 1, 1 to 2 and 2 to 3 HCs, the same trend can be observed and performance is not increased noticeably in our test scenario when running more than one HC.

- [No HC](https://snapshots.raintank.io/dashboard/snapshot/LCNjUHlltB1S21PICq8Kdj42LcEqXrPE)
- [1 HC](https://snapshots.raintank.io/dashboard/snapshot/jjkuCrhEIq26nzm4Z9OZgwyOEwuodZsq)
- [Up to 3 HCs](https://snapshots.raintank.io/dashboard/snapshot/RTYOzT0D8OsKFWjaSXW8s0npXu5gDos2)
- [3 HCs](https://snapshots.raintank.io/dashboard/snapshot/6XZaRIzWzR0pTebTkmXCypCqwyZ0MqrV)

## TODO

- perform selected benchmarks with a custom game of [Antistasi - Cam Lao Nam -
  Community
  Version](https://steamcommunity.com/sharedfiles/filedetails/?id=2479293826) to
  test real word performance.
- add data for 5900X with Server + 1 HC
