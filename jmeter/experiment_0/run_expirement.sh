#!/bin/bash
for i in $(seq 1 $END);
do
   docker-compose down
   docker-compose up -d
   sleep 10
   jmeter -n -t ../static_workload.jmx
done
docker-compose down