# Logs

To get logs from Loki, run:

```sh
logcli query '{container="server"}' \
  --forward \
  --timezone=Local \
  --from="2022-11-06T13:30:00Z" \
  --to="2022-11-06T17:00:00Z" \
  --limit=100000
```

## Antistasi Performance Statistics

To get performance stats from Antistasi in CSV, run:

```text
13:30:02 2022-11-06 13:30:02:776 | Antistasi | Info | File: A3A_fnc_logPerformance |  ServerFPS:33.195, Players:3, DeadUnits:22, AllUnits:43, UnitsAwareOfEnemies:0, AllVehicles:219, WreckedVehicles:4, Entities:285, GroupsRebels:8, GroupsInvaders:0, GroupsOccupants:0, GroupsCiv:1, GroupsTotal:9, GroupsCombatBehaviour:0, Faction Cash:\u003cnull\u003e, HR:\u003cnull\u003e, OccAggro: 40, InvAggro: 0, Warlevel: 9
```

```sh
rm logPerformance.csv
echo 'Timestamp,ServerFPS,Players,DeadUnits,AllUnits,UnitsAwareOfEnemies,AllVehicles,WreckedVehicles,Entities,GroupsRebels, GroupsInvaders,GroupsOccupants,GroupsCiv,GroupsTotal,GroupsCombatBehaviour,"Faction Cash",HR,OccAggro,InvAggro,Warlevel' > logPerformance.csv
logcli query '{container="server"}' \
  --forward \
  --timezone=Local \
  --from="2022-11-06T13:30:00Z" \
  --to="2022-11-06T17:00:00Z" \
  --limit=100000 \
    | cut -f 3-  -d" " \
    | jq  -r '.log' \
    | sed '/^$/d' \
    | grep "logPerformance" \
    | awk -F '|' '{print $1,$5}' \
    | sed -E 's/[a-z A-Z]+:/,/g;s/ /,/g;s/,+/,/g' \
    | cut -f 3- -d',' >> logPerformance.csv
```

1. get all logs for the given time (limit=10.000) from loki
1. remove the first two fields
1. print only the 'log' object
1. remove and empty lines
1. get only Antistasi 'logPerformance' lines
1. get only timestamp and actual performance stats (fields 1 and 5)
1. replace identifiers like 'ServerFPS' or 'Players' with ',', replace whitespaces with ',', remove any consecutive ','
1. remove duplicate timestamp

## Graphing the Results

To graph `ServerFPS` and `AllUnits`, run:

```sh
gnuplot -p antistasi.gnuplot
```