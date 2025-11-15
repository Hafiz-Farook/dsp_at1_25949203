# northwind-sql-analysis
Northwind SQL Analysis
Analysing Company Performance with SQL

This repository contains the full SQL-based analysis of the Northwind Traders dataset for the “Analysing Company Performance with SQL” assignment.

The goal of this project is to evaluate company performance across pricing, logistics, employee KPIs, and product behaviour, using complex SQL queries and analytical techniques.

📁 Repository Structure
northwind-sql-analysis/
│
├── queries/                # All SQL scripts (Q1–Q10)
│   ├── Q1.sql
│   ├── Q2.sql
│   ├── ...
│   └── Q10.sql
│
├── csv/                    # Query output results (CSV format)
│   ├── Q1.csv
│   ├── Q2.csv
│   ├── ...
│   └── Q10.csv
│
├── northwind.postgre.sql   # The original PostgreSQL dataset
│
├── report/
│   └── final-report.pdf    # Final written analysis
│
└── README.md               # Project documentation

🗄️ Dataset

The project uses the PostgreSQL Northwind Database (included as northwind.postgre.sql).
The dataset contains 13 relational tables including:

Products, Categories, Suppliers

Orders, Order Details, Shippers

Customers, Employees, Territories, Regions

This structure enables analysis of pricing, logistics, sales performance, and employee activity.

🛠️ Tools & Technologies

PostgreSQL 14+

pgAdmin / DBeaver / psql CLI

Git & GitHub

CSV exports

📥 How to Load the Database (PostgreSQL)
Option 1 — Using pgAdmin

Create a new database:
northwind

Right-click → Restore

Choose format: Custom or SQL file

Select northwind.postgre.sql

Click Restore

Option 2 — Using psql
createdb northwind
psql northwind < northwind.postgre.sql

▶️ Running the SQL Queries

Each business question corresponds to a separate SQL script:

File	Description
queries/Q1.sql	Product pricing range analysis
queries/Q2.sql	Logistics shipping delay analysis (1998)
queries/Q3.sql	Employee hire age + manager details
queries/Q4.sql	Monthly freight + orders (1997–1998)
queries/Q5.sql	Price increase percentage detection
queries/Q6.sql	Category revenue by price range
queries/Q7.sql	Supplier regional stock analysis
queries/Q8.sql	Product vs category average/median
queries/Q9.sql	Employee sales KPIs
queries/Q10.sql	Category-employee sales distribution
How to run

In pgAdmin or DBeaver:

Open the SQL file (e.g. Q3.sql)

Execute

Export the result table as CSV

Save it in /csv/ with the same question number

📄 Final Report

The final written analysis is located in:

report/final-report.pdf


This document summarises:

Methods used

Insights from each business question

Employee performance KPIs

Category-level pricing behaviour

Logistics and shipping performance trends

🚀 Development Setup (Optional)

Clone this repo:

git clone https://github.com/YOUR_GITHUB_USERNAME/northwind-sql-analysis.git
cd northwind-sql-analysis


Push updates:

git add .
git commit -m "Added SQL queries and CSV outputs"
git push

👤 Author

Hafiz Farook
Master of Data Science & Innovation
University of Technology Sydney 
