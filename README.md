# 🚕 NYC Yellow Taxi Big Data Analysis

## Hadoop MapReduce & Apache Pig

A Big Data Analysis project using **Apache Hadoop, HDFS, Hadoop MapReduce, and Apache Pig** to analyze NYC Yellow Taxi Trip Data for March 2016.

---

## 📌 Project Overview

This project demonstrates a complete Big Data processing workflow:

```text
NYC Yellow Taxi Dataset
        ↓
   HDFS Storage
        ↓
 Hadoop MapReduce
   ├── Total Trips
   ├── Payment Type
   └── Average Distance
        ↓
    Apache Pig
   ├── Total Revenue
   ├── Average Fare
   ├── Passenger Count
   ├── Longest Trips
   └── Payment Analysis
        ↓
      Results
```

---

# 📊 Dataset

**Dataset:** NYC Yellow Taxi Trip Data — March 2016

The original dataset is approximately **1.8 GB** with around **12.21 million records**.

For this laboratory project, a reduced subset of approximately **600,000 records** was used to reduce processing time and resource requirements.

The working dataset was processed using Hadoop MapReduce and Apache Pig.

---

# 🛠️ Technologies

| Technology       | Version         |
| ---------------- | --------------- |
| Operating System | Windows 10      |
| Java             | JDK 8           |
| Hadoop           | 3.2.4           |
| Apache Pig       | 0.18.0          |
| Storage          | HDFS            |
| Processing       | MapReduce + Pig |
| Dataset Format   | CSV             |

---

# 📁 Project Structure

```text
NYC-Yellow-Taxi-Analysis/
│
├── dataset/
│   └── yellow_tripdata_2016_03_6000.csv
│
├── mapreduce/
│   ├── MR1_TotalTrips/
│   ├── MR2_PaymentType/
│   └── MR3_AverageDistance/
│
├── pig/
│   ├── P1_TotalRevenue/
│   ├── P2_AverageFare/
│   ├── P3_PassengerCount/
│   ├── P4_LongestTrips/
│   └── P5_PaymentAnalysis/
│
├── output/
│   └── pig/
│
├── screenshots/
├── commands/
└── report/
```

---

# 1️⃣ Start Hadoop

Open **Command Prompt / PowerShell**.

Go to Hadoop:

```powershell
cd C:\hadoop
```

Start HDFS:

```powershell
start-dfs.cmd
```

Start YARN:

```powershell
start-yarn.cmd
```

---

# 2️⃣ Verify Hadoop Services

Run:

```powershell
jps
```

Expected output:

```text
NameNode
DataNode
ResourceManager
NodeManager
Jps
```

These services confirm that Hadoop is running correctly.

---

# 3️⃣ Hadoop Web Interfaces

## NameNode Web UI

Open:

```text
http://localhost:9870
```

The NameNode UI shows:

* HDFS information
* Live DataNodes
* Storage information
* HDFS directories
* Cluster overview

## ResourceManager Web UI

Open:

```text
http://localhost:8088
```

The ResourceManager UI shows:

* Running applications
* Finished applications
* Application status
* YARN resources
* Memory and CPU usage

## Job History Server

If configured/running:

```text
http://localhost:19888
```

This can be used to view completed MapReduce jobs.

---

# 4️⃣ Create HDFS Project Directory

Create the input directory:

```powershell
hdfs dfs -mkdir -p /NYC-Yellow-Taxi-Analysis/input
```

Create the output directory:

```powershell
hdfs dfs -mkdir -p /NYC-Yellow-Taxi-Analysis/output
```

Check directories:

```powershell
hdfs dfs -ls /NYC-Yellow-Taxi-Analysis
```

---

# 5️⃣ Upload Dataset to HDFS

From the project directory:

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis"
```

Upload the dataset:

```powershell
hdfs dfs -put ".\dataset\yellow_tripdata_2016_03_6000.csv" /NYC-Yellow-Taxi-Analysis/input/
```

Check:

```powershell
hdfs dfs -ls -h /NYC-Yellow-Taxi-Analysis/input
```

View the first few records:

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/input/yellow_tripdata_2016_03_6000.csv | Select-Object -First 5
```

---

# 6️⃣ Prepare Dataset for Apache Pig

The CSV header is removed because the Pig schema is defined manually.

Run:

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/input/yellow_tripdata_2016_03_6000.csv | Select-Object -Skip 1 | hdfs dfs -put - /NYC-Yellow-Taxi-Analysis/input/taxi_noheader.csv
```

Check:

```powershell
hdfs dfs -ls -h /NYC-Yellow-Taxi-Analysis/input
```

The input directory should contain:

```text
yellow_tripdata_2016_03_6000.csv
taxi_noheader.csv
```

---

# 7️⃣ Hadoop MapReduce Operations

## MR1 — Total Number of Taxi Trips

### Purpose

Counts the total number of valid taxi trip records.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\mapreduce\MR1_TotalTrips"
```

Compile:

```powershell
javac -classpath "%HADOOP_HOME%\share\hadoop\common\*;%HADOOP_HOME%\share\hadoop\common\lib\*;%HADOOP_HOME%\share\hadoop\mapreduce\*;%HADOOP_HOME%\share\hadoop\mapreduce\lib\*" -d . *.java
```

Create JAR:

```powershell
jar -cvf MR1_TotalTrips.jar *.class
```

Run:

```powershell
hadoop jar MR1_TotalTrips.jar MR1_TotalTrips /NYC-Yellow-Taxi-Analysis/input/yellow_tripdata_2016_03_6000.csv /NYC-Yellow-Taxi-Analysis/output/MR1_TotalTrips
```

If the output directory already exists:

```powershell
hdfs dfs -rm -r /NYC-Yellow-Taxi-Analysis/output/MR1_TotalTrips
```

Then run the Hadoop command again.

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/MR1_TotalTrips/part-r-00000
```

---

# 8️⃣ MR2 — Trips by Payment Type

### Purpose

Counts the number of trips for each payment type.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\mapreduce\MR2_PaymentType"
```

Compile:

```powershell
javac -classpath "%HADOOP_HOME%\share\hadoop\common\*;%HADOOP_HOME%\share\hadoop\common\lib\*;%HADOOP_HOME%\share\hadoop\mapreduce\*;%HADOOP_HOME%\share\hadoop\mapreduce\lib\*" -d . *.java
```

Create JAR:

```powershell
jar -cvf MR2_PaymentType.jar *.class
```

Run:

```powershell
hadoop jar MR2_PaymentType.jar MR2_PaymentType /NYC-Yellow-Taxi-Analysis/input/yellow_tripdata_2016_03_6000.csv /NYC-Yellow-Taxi-Analysis/output/MR2_PaymentType
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/MR2_PaymentType/part-r-00000
```

---

# 9️⃣ MR3 — Average Trip Distance

### Purpose

Calculates the average distance travelled by taxis.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\mapreduce\MR3_AverageDistance"
```

Compile:

```powershell
javac -classpath "%HADOOP_HOME%\share\hadoop\common\*;%HADOOP_HOME%\share\hadoop\common\lib\*;%HADOOP_HOME%\share\hadoop\mapreduce\*;%HADOOP_HOME%\share\hadoop\mapreduce\lib\*" -d . *.java
```

Create JAR:

```powershell
jar -cvf MR3_AverageDistance.jar *.class
```

Run:

```powershell
hadoop jar MR3_AverageDistance.jar MR3_AverageDistance /NYC-Yellow-Taxi-Analysis/input/yellow_tripdata_2016_03_6000.csv /NYC-Yellow-Taxi-Analysis/output/MR3_AverageDistance
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/MR3_AverageDistance/part-r-00000
```

---

# 🐷 10️⃣ Apache Pig Operations

All Pig operations use:

```text
/NYC-Yellow-Taxi-Analysis/input/taxi_noheader.csv
```

Pig is executed in MapReduce mode:

```powershell
pig -x mapreduce filename.pig
```

---

# Pig 1 — Total Taxi Revenue

### Purpose

Calculates the total revenue generated from valid taxi trips.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P1_TotalRevenue"
pig -x mapreduce p1_total_revenue.pig
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P1_TotalRevenue/part-r-00000
```

Operations used:

```text
FILTER → GROUP → SUM
```

---

# Pig 2 — Average Fare by Payment Type

### Purpose

Calculates the average fare for each payment type.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P2_AverageFare"
pig -x mapreduce p2_average_fare.pig
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P2_AverageFare/part-r-00000
```

Operations used:

```text
FILTER → GROUP → AVG
```

---

# Pig 3 — Trips by Passenger Count

### Purpose

Counts taxi trips according to passenger count.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P3_PassengerCount"
pig -x mapreduce p3_passenger_count.pig
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P3_PassengerCount/part-r-00000
```

Operations used:

```text
FILTER → GROUP → COUNT → ORDER
```

---

# Pig 4 — Top 10 Longest Trips

### Purpose

Finds the 10 longest valid taxi trips.

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P4_LongestTrips"
pig -x mapreduce p4_longest_trips.pig
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P4_LongestTrips/part-r-00000
```

Operations used:

```text
FILTER → ORDER → LIMIT → FOREACH
```

---

# Pig 5 — Payment Type Analysis

### Purpose

Analyzes payment types based on:

* Total trips
* Total revenue
* Average trip distance

### Run

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P5_PaymentAnalysis"
pig -x mapreduce p5_payment_analysis.pig
```

### Show Result

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P5_PaymentAnalysis/part-r-00000
```

Operations used:

```text
FILTER → GROUP → COUNT → SUM → AVG → ORDER
```

---

# 11️⃣ Check All HDFS Results

To view all project directories:

```powershell
hdfs dfs -ls -R /NYC-Yellow-Taxi-Analysis
```

To check MapReduce outputs:

```powershell
hdfs dfs -ls /NYC-Yellow-Taxi-Analysis/output
```

To check Pig outputs:

```powershell
hdfs dfs -ls /NYC-Yellow-Taxi-Analysis/output/pig
```

---

# 12️⃣ YARN Application History

Show completed applications:

```powershell
yarn application -list -appStates FINISHED
```

Show running applications:

```powershell
yarn application -list -appStates RUNNING
```

Show all applications:

```powershell
yarn application -list
```

This can be demonstrated using the ResourceManager UI:

```text
http://localhost:8088
```

---

# 13️⃣ HDFS Web Interface

Open:

```text
http://localhost:9870
```

Useful sections:

### Utilities → Browse the file system

Navigate to:

```text
/NYC-Yellow-Taxi-Analysis
```

Then show:

```text
input/
output/
```

This demonstrates that the dataset and generated results are stored in HDFS.

---

# 14️⃣ Result Download

Pig results can be downloaded from HDFS to the local project.

Example:

```powershell
hdfs dfs -get /NYC-Yellow-Taxi-Analysis/output/pig/P1_TotalRevenue/part-r-00000 "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\output\pig\P1_TotalRevenue\result.txt"
```

Repeat for the other Pig operations.

---

# 📸 15️⃣ Recommended Screenshots for Demonstration

The `screenshots/` folder should contain screenshots of:

### Hadoop

1. `01-hadoop-jps.png`
2. `02-namenode-localhost.png`
3. `03-resourcemanager-localhost.png`

### HDFS

4. `04-hdfs-input.png`
5. `05-hdfs-dataset.png`

### MapReduce

6. `06-mr1-execution.png`
7. `07-mr1-result.png`
8. `08-mr2-execution.png`
9. `09-mr2-result.png`
10. `10-mr3-execution.png`
11. `11-mr3-result.png`

### Pig

12. `12-pig1-execution-result.png`
13. `13-pig2-execution-result.png`
14. `14-pig3-execution-result.png`
15. `15-pig4-execution-result.png`
16. `16-pig5-execution-result.png`

### YARN

17. `17-yarn-applications.png`

---

# 📋 16️⃣ Final Analysis Summary

| Technology | Operation | Purpose                      |
| ---------- | --------- | ---------------------------- |
| MapReduce  | MR1       | Total Taxi Trips             |
| MapReduce  | MR2       | Trips by Payment Type        |
| MapReduce  | MR3       | Average Trip Distance        |
| Pig        | P1        | Total Taxi Revenue           |
| Pig        | P2        | Average Fare by Payment Type |
| Pig        | P3        | Trips by Passenger Count     |
| Pig        | P4        | Top 10 Longest Trips         |
| Pig        | P5        | Payment Type Analysis        |

---

# 🎯 Learning Outcomes

This project demonstrates practical knowledge of:

* Hadoop ecosystem
* HDFS
* YARN
* MapReduce
* Apache Pig
* Distributed data processing
* Data filtering
* Data grouping
* Aggregation
* Sorting
* Large-scale dataset analysis

---

# ⚠️ Dataset Notice

The complete 1.8 GB dataset is not included in this GitHub repository.

The project uses a reduced working dataset of approximately **600,000 records**.

Dataset source:

**NYC Yellow Taxi Trip Data — March 2016**

---

# 👨‍💻 Author

**Md Sakib**

Computer Science & Engineering
Premier University, Chattogram, Bangladesh

---

# ⭐ Project Workflow

```text
1. Start Hadoop
       ↓
2. Verify with JPS
       ↓
3. Open NameNode UI
       ↓
4. Open ResourceManager UI
       ↓
5. Create HDFS directories
       ↓
6. Upload dataset
       ↓
7. Run 3 MapReduce operations
       ↓
8. Show MapReduce results
       ↓
9. Run 5 Pig operations
       ↓
10. Show Pig results
       ↓
11. Check HDFS outputs
       ↓
12. Check YARN applications
       ↓
13. Download results
       ↓
14. Present screenshots & report
```

## 🌐 Important Localhost Links

| Service               | URL                    |
| --------------------- | ---------------------- |
| Hadoop NameNode       | http://localhost:9870  |
| YARN ResourceManager  | http://localhost:8088  |
| MapReduce Job History | http://localhost:19888 |

> **Note:** `localhost:19888` is available only if the MapReduce JobHistory Server is configured and running.
