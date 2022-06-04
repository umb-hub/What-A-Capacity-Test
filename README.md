# What A Capacity Test?
Let's create website's capacity test

## Abstract
*What is a capacity test?*

Capacity test is a **testing measure** that evaluates the speed, responsiveness and stability of a computer, network, software program or device under a workload. Organizations will run those tests in order to **identify performance-related bottlenecks**.

More generally, performance analysis refers to characterizing performance under several working conditions.

Performance analysis can be characterized by several indicators, in this work a web server will be studied using those indicators:

- *Response Rate (Throughput)*
- *Latency*
- *Requests Failed*

## Description

In this work a capacity test, on Apache WebServer connected with a MySQL DataBase, will be runned in following steps:

1. Create a **System Design Architecture** based on container technology, those container will be runned using limited resources to elaborate differents tests

2. Define a proper **experimental design** to run out using common techniques in State of Art

3. Collect several **observations** (repetitions) for each value of design

4. Perform a performance analysis to determine a proper system configuration using **allocation of variation** and **ANOVA** techniques

5. Perform a capacity test to determinate **knee** and the **usable** capacity point of work of system defined in previuos step

## System Design 

All tests will be runned on MacBook Air 2020 using those specs:

- CPU: Apple M1 (Arm 64-bit)
- RAM: 8GB

Docker will run on this specs:

- Docker cores: 4
- Docker RAM: 4 GB

WebServer is built on simple **2-tier architecture**, using 2 different **Docker container** described using this deployment diagram:

![Deploy Diagram](./images/deploy.png)

Tested environment has different components, which include artefacts and interfaces in order to comunicate each other.

### Apache HTTP Server 

Apache HTTP Server is a docker container with prebuilded image, that contains Apache WebServer configured with php module, in listening on port 80. Futhermore, MySQL connector is installed to communicate with MariaDB component.

There are differents files uploaded in container, those artefacts are usefull to create 3 type of different workload:

- **Static Workload**: include only html static pages to download
- **Dynamic Workload**: static and dynamic pages are generated using operation on database

### MariaDB Server

MariaDB Server is a docker continer with prebuilded image with preconfigured MySQL service in listening on port 3306.

`dbapp.sql` file is preloaded in `/docker-entrypoint-initdb.d` path to init e populate database.

### Apache JMeter

Clients are simulated using a load tester: **Apache JMeter** is an application designed to **measure performance** and **load test** applications.

For each workload a JMeter test will be replicated more times in order to collect data for case study.

## Experimental Design

An experiment is a test in which changes are made to the input variables of a system or process with the aim of **observing and identifying the reasons of changes in the output**.

Some of contrallable input are identified to study the response:

- Apache HTTP Server CPU
- Apache HTTP Server RAM
- MariaDB Server CPU
- MariaDB Server RAM
- Workload

For each factor a minimun and maximum level will be evaluated:

| Level | 1 | 2 |
| :-: | :-: | :-: |
| **Apache CPU** | 0.125 vCPU | 0.5 vCPU |
| **MariaDB CPU** | 0.125 vCPU | 0.5 vCPU |
| **Apache RAM** | 256 MB | 1 GB |
| **MariaDB RAM** | 256 MB | 1 GB |
| **Workload** | Static | Dynamic |

The response to be evuluted is the **mean throughput** of system.

### Fraction Factor Design

A full factor design $2^5*5$ would require a total of 160 experiments, in order to reduce number of expirements a fractional factor design $2^{5-2}*5$ will be placed on with a total of 40 expirements. 

Using following association:

| Factor | Name |
| :-: | :-: |
| **Apache CPU** | A |
| **MariaDB CPU** | B |
| **Apache RAM** | C |
| **MariaDB RAM** | D|
| **Workload** | E |

#### Effect Confusion

A decision needs to be taken about factor confusion, in particular designer decided to confuse:

- A = CE
- B = DE

Sign table will be generated simply using `itertools`:

```python
import itertools
import pandas as pd

C = [-1, +1]
D = [-1 , +1]
E = [-1 , +1]

Table = []

for x in itertools.product(C, D, E):
  Table.append(x)

TableSign = pd.DataFrame(Table, columns=["C", "D", "E"])
TableSign["CD"] = TableSign["C"] * TableSign["D"]
TableSign["CE"] = TableSign["C"] * TableSign["E"]
TableSign["DE"] = TableSign["D"] * TableSign["E"]
TableSign["CDE"] = TableSign["C"] * TableSign["D"] * TableSign["E"]
TableSign.to_markdown()
```

Result:

|  Experiment  |   C |   D |   E |   CD | A=CE | B=DE |   CDE |
|---:|----:|----:|----:|-----:|-----:|-----:|------:|
|  0 |  -1 |  -1 |  -1 |    1 |    1 |    1 |    -1 |
|  1 |  -1 |  -1 |   1 |    1 |   -1 |   -1 |     1 |
|  2 |  -1 |   1 |  -1 |   -1 |    1 |   -1 |     1 |
|  3 |  -1 |   1 |   1 |   -1 |   -1 |    1 |    -1 |
|  4 |   1 |  -1 |  -1 |   -1 |   -1 |    1 |     1 |
|  5 |   1 |  -1 |   1 |   -1 |    1 |   -1 |    -1 |
|  6 |   1 |   1 |  -1 |    1 |   -1 |   -1 |    -1 |
|  7 |   1 |   1 |   1 |    1 |    1 |    1 |     1 |

Algebra of confunding is usefull to obtain generator polynomial and find relationship of confusions.
$$
\begin{cases}
A = CE \\
B = DE \\
\end{cases} \implies AB= CD
$$

This relationship is usefull to find generator polynomial $I$:

$$ CD = AB$$
$$ CD \cdot D = AB \cdot D $$
$$ C = ABD $$
$$ C \cdot C = ABD \cdot C $$
$$ I = ABCD$$

Generator polynomial can be used to calculate all of confounded effects:

| Effect | Confounded 1 | Confounded 2 | Confounded 3 |
| :-: | :-: | :-: | :-: |
| C | AE | ABD | BCDE | 
| D | BE | ABC | ACDE |
| E | AC | BD | ABCDE |
| CD | AB | BCE | ADE |
| CE | A | BCE | ABDE |
| DE | B | ACD | ABCE |
| CDE | AD | AC | ABE |

#### Model Design

The response to be evuluted is the **mean throughput** of system.

The response will be modeled using a linear regression:

$$y = q_C x_C + q_D x_D + q_E x_E + q_{CD} x_{CD} + q_{DE} x_{DE} + q_{CDE} x_{CDE}$$


## Data collection

In order to collect usefull data, containing **knee** and **usable** capacity point of work, it is needed to stress system untils its usable point.

### Workload Characterization

Preliminar tests will be conducted, on highest level of each parameter, to individuate a **load test configuration** in JMeter that led to system errors. Futhermore, a particular focus is paid on JMeter exceptions, workload is tuned in order to avoid any client error.

Simulated workload will be rappresentative for a stress test on WebServer using those criterias:

- A lot of people try to connect server
- Number of user active is incremental: half of test time is used to activate all user and the other one is used on full load
- Each user generate a traffic with a few of seconds for request
- Different static pages will be loaded using a **Random Order Controller** in order to generate a static traffic considering 2MB as mean of generic HTML page size.
- Dynamic workload will be performed using a **Random Controller** in order to generate random traffic using static pages and dynamic webpages with database operations

In summary this **workload characterization** will be placed on:

| Parameter | Value |
| :- | :-: |
| Test duration | 5 minutes |
| Virtual users | 300 threads |
| Ramp-up period | 150 seconds |
| Throughput (for user) | 30 requests/minute |
| Static Workload| Static HTTP pages sized: <br> 500KB <br> 1MB <br> 2MB <br> |
| Dynamic Workload | PHP using r/w operation on MySQL Server and static HTTP pages |