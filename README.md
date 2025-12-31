# Investor Profile Scoring – PostgreSQL

This repository contains a runnable PostgreSQL mini-project created as part of a technical evaluation.
It demonstrates how to design reusable database functions and a dynamic scoring system using
configuration-driven business logic.

---

## 📌 Problem Statement

In real-world financial systems, an investor profile is considered complete only when
key details such as contact information, bank details, nominees, and KYC documents are provided.

This project calculates an **Investor Profile Completion Score (out of 100)** dynamically,
without hardcoding business rules inside SQL logic.

---

## 🎯 Features

- Unique random investor code generator (PL/pgSQL function)
- Dynamic profile scoring based on configurable rules
- No hardcoded weights or scores
- Clean separation of schema, data, functions, and execution
- Runnable using a single Python command

---

## 🛠 Tech Stack

- PostgreSQL (PL/pgSQL)
- Python 3
- psycopg2
- python-dotenv

---

## 📂 Project Structure

```
investor-profile-scoring-postgres/
│
├── README.md
├── requirements.txt
├── .env.example
├── run_project.py
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_sample_data.sql
│   ├── 03_random_code_function.sql
│   ├── 04_scoring_rules.sql
│   └── 05_profile_score.sql
```
---

## ⚙️ Setup Instructions (Without Docker)

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/srisrini271/investor-profile-scoring-postgres.git
cd investor-profile-scoring-postgres
```

---

### 2️⃣ Create and Activate Virtual Environment
```bash
python -m venv venv
```

Activate the environment:

**Windows**
```bash
venv\Scripts\activate
```

**Mac / Linux**
```bash
source venv/bin/activate
```

---

### 3️⃣ Install Dependencies
```bash
pip install -r requirements.txt
```

---

### 4️⃣ Create PostgreSQL Database
```sql
CREATE DATABASE investor_db;
```

---

### 5️⃣ Configure Environment Variables
```bash
cp .env.example .env
```

Update `.env` with your database credentials:
```env
DATABASE_URL=postgresql://username:password@localhost:5432/investor_db
```

---

### 6️⃣ Run the Project 🚀
```bash
python run_project.py
```

---

## ✅ What Happens When You Run the Script

- Existing tables are dropped (clean setup)
- All schema and functions are created
- Sample data is inserted
- A unique investor code is generated
- Investor profile scores are calculated
- Output is displayed in a readable tabular format

---

## 📊 Sample Output

```
Investor     Contact   Photo   Bank   Nominee   KYC    Total
------------------------------------------------------------
INV001       20        20      20     20        20     100/100
INV002       10        20      0      0         0      30/100
```

---

## 🧠 Design Highlights

- Business rules stored in configuration tables
- Easy to add or modify scoring rules without code changes
- Production-style SQL and execution flow
- Clean, interview-friendly project structure

---

## 📝 Notes

This project was created to demonstrate:
- PostgreSQL function design
- Dynamic SQL-based scoring logic
- Backend problem-solving approach
- Clean and maintainable project structure
