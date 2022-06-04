#!/bin/bash
for i in {1..5}
do
   docker-compose down
   docker-compose up -d
   sleep 10
   jmeter -n -t ../static_workload.jmx
done
