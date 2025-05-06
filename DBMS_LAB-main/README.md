# 👤 Author: Tanmay Kalinkar
# PRN: 23070521189

# ⚽ Football Management System – DBMS Project

A comprehensive Football Management System built using MySQL and Oracle SQL (PL/SQL), showcasing core database operations including table creation, joins, subqueries, views, triggers, indexes, and stored procedures.

## 📁 Contents

- `All_Dbms_Practicals.sql` – All table creation scripts, joins, subqueries, triggers, views, and PL/SQL procedure
- `README.md` – Project documentation and instructions

## 📌 Features Implemented

- 🗃️ **Table Creation**: `teams`, `players`, `matches`, `arenas`, `leagues`, `users`, `match_stats`
- 🔍 **Subqueries**: Nested queries to fetch players from specific teams, arenas with large capacities, etc.
- 🔗 **Joins**: Inner, Left, Right, Full (via Union), and Self Joins
- 👀 **Views**: Simplified view of players and their teams
- ⚙️ **Indexes**: Speed up searches using `team_name` and `match date`
- 🔁 **Triggers**: Automatically calculate age before user insertion
- 💾 **PL/SQL Procedure**: Fund transfer simulation with error handling

## 💻 Setup Instructions

### Requirements

- MySQL Workbench or any MySQL client
- Oracle SQL*Plus for PL/SQL procedures
- Git and GitHub (for version control and sharing)

### To Run:

1. Import and run the SQL script in your MySQL client
2. For PL/SQL operations, copy the procedure into Oracle SQL*Plus or Oracle Live SQL

## 🧠 Learning Outcomes

- Mastery of SQL concepts via real-world football database design
- Exposure to relational modeling, integrity constraints, and transaction simulation
- Integration of MySQL and Oracle-specific capabilities
