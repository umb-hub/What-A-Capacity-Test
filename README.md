# What A Capacity Test?
Let's create website's capacity test

## Abstract
*What is a capacity test?*

Capacity test is a testing measure that evaluates the speed, responsiveness and stability of a computer, network, software program or device under a workload. Organizations will run those tests in order to identify performance-related bottlenecks.

More generally, performance analysis refers to characterizing performance under several working conditions.

Performance analysis can be characterized by several indicators, in this work a web server will be studied using those indicators:

- *Response Rate (Throughput)*
- *Latency*
- *Requests Failed*

## Description

In this work a capacity test on Apache Web Server, connected with a MySQL DataBase, will be runned in following steps:

1. Create a System Design Architecture based on container technology, those container will be runned using limited resources in order to elaborate differents tests

2. Define a proper experimental design to run out using common techniques in State of Art

3. Collect several observations (repetitions) for each value of design condition

4. Perform a performance analysis in order to determine a proper system configuration using *allocation of variation* and *ANOVA* techniques

5. Perform a capacity test in order to determine knee and the usable capacity point of work of system

### System Design 

All tests will be runned on MacBook Air 2020 using those specs:

- CPU: Apple M1 (Arm 64-bit)
- RAM: 8GB

Web server is built on simple 2-tier architecture, using 2 different Docker container described using this deployment diagram:

![Deploy Diagram](./images/deploy.png)

Tested environment has different components, which include artefacts and interfaces in order to comunicate each other.

#### Apache HTTP Server 

Apache HTTP Server is a docker container with prebuild php image, that contains apache web server configured with php module. Futhermore, mysql connector is installed in order to communicate with MariaDB component.

There are differents files uploaded in container, those artefacts are usefull to create 3 type of different workload:

- **Static Workload**: include only html static pages to download
- **Read Database Workload**: execute index.php in order to read data from MariaDB database
- **Read and Write Database Workload**: execute index.php in order to read and write on MariaDB database.

#### MariaDB Server

MariaDB Server is a docker continer with prebuild image with preconfigured MySQL service in listening on port 3306.

‘‘‘dbapp.sql‘‘‘ file is preloaded in ‘‘‘/docker-entrypoint-initdb.d‘‘‘ path in order to init e populate database.

#### Apache JMeter

Apache JMeter is an application designed to measure performance and load test applications.

For each workload a jmeter test will be replicated more times in order to collect data for case study.