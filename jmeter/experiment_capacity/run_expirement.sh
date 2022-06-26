#!/bin/bash
for i in $(seq 1 $END);
do
   docker-compose down
   docker-compose up -d
   sleep 120
   jmeter -n -t ../dynamic_workload.jmx
done
docker-compose down
