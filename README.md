# 🚕 NYC Yellow Taxi Trip Data Analysis

A Big Data Analysis project using **Hadoop MapReduce** and **Apache Pig** to analyze NYC Yellow Taxi Trip Data from **March 2016**.

---

## 📌 Project Overview

This project demonstrates how Big Data technologies can be used to process and analyze large-scale taxi trip data.

The project performs:

* **3 Hadoop MapReduce Operations**
* **5 Apache Pig Operations**
* Data storage and processing using **HDFS**
* Analysis of taxi trips, fares, revenue, payment methods, passengers, and trip distances

---

## 📊 Dataset

**Dataset:** NYC Yellow Taxi Trip Data — March 2016

**Dataset Link:** https://github.com/sakibskb143/NYC_Yellow_Taxi_Big_Data_Analysis_using_Hadoop

**Source:** Kaggle — NYC Yellow Taxi Trip Data

The original dataset is approximately **1.8 GB** with around **12.21 million records**. For this project, a reduced subset of approximately **600,000 records** was used to reduce processing time and resource requirements.

The working dataset was processed using Hadoop MapReduce and Apache Pig.

---

## 🛠️ Technologies Used

* Java 8
* Hadoop 3.2.4
* Apache Pig 0.18.0
* HDFS
* Hadoop MapReduce
* PowerShell
* CSV Dataset
* Windows 10

---

## 📁 Project Structure

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
│       ├── P1_TotalRevenue/
│       ├── P2_AverageFare/
│       ├── P3_PassengerCount/
│       ├── P4_LongestTrips/
│       └── P5_PaymentAnalysis/
│
├── screenshots/
├── commands/
└── report/
```

---

# 🔹 MapReduce Operations

### 1. Total Number of Taxi Trips

Counts the total number of taxi trips in the working dataset.

### 2. Trips by Payment Type

Counts the number of taxi trips for each payment type.

### 3. Average Trip Distance

Calculates the average trip distance of the taxi trips.

---

# 🔹 Apache Pig Operations

### 1. Total Taxi Revenue

Calculates the total revenue generated from all valid taxi trips.

**Pig Operations:** `FILTER`, `GROUP`, `SUM`

### 2. Average Fare by Payment Type

Calculates the average fare for each payment type.

**Pig Operations:** `FILTER`, `GROUP`, `AVG`

### 3. Trips by Passenger Count

Counts taxi trips according to the number of passengers.

**Pig Operations:** `FILTER`, `GROUP`, `COUNT`, `ORDER`

### 4. Top 10 Longest Taxi Trips

Finds the 10 longest valid taxi trips.

**Pig Operations:** `FILTER`, `ORDER`, `LIMIT`, `FOREACH`

### 5. Payment Type Analysis

Analyzes each payment type based on:

* Total trips
* Total revenue
* Average trip distance

**Pig Operations:** `FILTER`, `GROUP`, `COUNT`, `SUM`, `AVG`, `ORDER`

---

# ⚙️ Hadoop Setup

Start Hadoop services using PowerShell:

```powershell
start-dfs.cmd
start-yarn.cmd
```

Check running services:

```powershell
jps
```

Expected services:

```text
NameNode
DataNode
ResourceManager
NodeManager
```

---

# 🗂️ HDFS Input

Create the project input directory:

```powershell
hdfs dfs -mkdir -p /NYC-Yellow-Taxi-Analysis/input
```

Upload the dataset:

```powershell
hdfs dfs -put ".\dataset\yellow_tripdata_2016_03_6000.csv" /NYC-Yellow-Taxi-Analysis/input/
```

Check the uploaded file:

```powershell
hdfs dfs -ls -h /NYC-Yellow-Taxi-Analysis/input
```

---

# 🐷 Running Apache Pig

Example:

```powershell
cd "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\pig\P1_TotalRevenue"
pig -x mapreduce p1_total_revenue.pig
```

View the output:

```powershell
hdfs dfs -cat /NYC-Yellow-Taxi-Analysis/output/pig/P1_TotalRevenue/part-r-00000
```

---

# 📤 Download Pig Results

Example:

```powershell
hdfs dfs -get /NYC-Yellow-Taxi-Analysis/output/pig/P1_TotalRevenue/part-r-00000 "C:\Users\Md Sakib\Desktop\NYC-Yellow-Taxi-Analysis\output\pig\P1_TotalRevenue\result.txt"
```

---

# 📈 Analysis

The project provides insights into:

* Total taxi trips
* Payment method usage
* Average trip distance
* Total taxi revenue
* Average fare
* Passenger distribution
* Longest taxi trips
* Revenue by payment type

These operations demonstrate how **MapReduce and Pig can process and analyze large-scale datasets using distributed data processing techniques**.

---

# 📸 Screenshots

Screenshots of:

* Hadoop services (`jps`)
* HDFS dataset upload
* MapReduce execution
* Pig execution
* Pig output
* HDFS directories

are included in the `screenshots/` directory.

---

# 📄 Report

The complete laboratory report is available in:

```text
report/
```

---

# ⚠️ Dataset Note

The original NYC Taxi dataset is large, so the complete dataset is **not included in this repository**.

A reduced working dataset of approximately **600,000 records** was used for the analysis.

Dataset source:

**Kaggle — NYC Yellow Taxi Trip Data**

---

# 👨‍💻 Author

**Md Sakib**

CSE Student
Premier University, Chattogram, Bangladesh

---

## ⭐ Project Summary

This project demonstrates practical implementation of:

```text
Large Dataset
     ↓
     HDFS
     ↓
Hadoop MapReduce
     ↓
Apache Pig
     ↓
Data Analysis
     ↓
Results & Insights
```

---

## 📌 Learning Outcomes

Through this project, I learned how to:

* Store datasets in HDFS
* Perform distributed data processing
* Write Java MapReduce programs
* Write Apache Pig scripts
* Perform filtering, grouping, sorting and aggregation
* Analyze Big Data using Hadoop ecosystem tools
* Manage Big Data projects on a Windows environment
