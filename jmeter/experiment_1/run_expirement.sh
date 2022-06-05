#!/bin/bash
for i in {1..5}
do
   docker-compose down
   docker-compose up -d
   sleep 120
   jmeter -n -t ../dynamic_workload.jmx
done
docker-compose down
