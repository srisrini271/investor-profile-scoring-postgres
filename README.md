# Investor Profile Scoring (PostgreSQL)

This project demonstrates:
- A reusable random unique code generator function
- A dynamic investor profile scoring system
- Clean PostgreSQL design without hardcoded values

## Prerequisites
- PostgreSQL 13 or above
- psql or pgAdmin

## Setup Steps

1. Create database
   CREATE DATABASE investor_db;

2. Connect to database
   \c investor_db

3. Run SQL files in order
   \i sql/01_schema.sql
   \i sql/02_sample_data.sql
   \i sql/03_random_code_function.sql
   \i sql/04_scoring_rules.sql
   \i sql/05_profile_score.sql

## Usage

Generate unique investor code:
SELECT generate_random_number('INV','investor','investor_code',10);

Calculate profile scores:
SELECT * FROM investor_profile_score;

## Key Design Points
- No hardcoded scores
- Easy to extend scoring rules
- Interview-ready SQL logic
