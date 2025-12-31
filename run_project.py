"""
Investor Profile Scoring - PostgreSQL Runner
Runs all SQL scripts against a PostgreSQL database.
"""

import os
import sys
from pathlib import Path

try:
    import psycopg2
    from dotenv import load_dotenv
except ImportError:
    print("Missing dependencies. Run: pip install -r requirements.txt")
    sys.exit(1)

# Load environment variables
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    print("ERROR: DATABASE_URL not found in .env file")
    print("\nTo set up:")
    print("1. Get a FREE PostgreSQL database from https://neon.tech")
    print("2. Copy .env.example to .env")
    print("3. Add your connection string to .env")
    sys.exit(1)

# SQL files in order
SQL_FILES = [
    "sql/01_schema.sql",
    "sql/02_sample_data.sql",
    "sql/03_random_code_function.sql",
    "sql/04_scoring_rules.sql",
]

QUERY_FILE = "sql/05_profile_score.sql"


def run_sql_file(cursor, filepath):
    """Execute a SQL file."""
    with open(filepath, "r") as f:
        sql = f.read()
    cursor.execute(sql)
    print(f"  ✓ {filepath}")


def main():
    print("\n" + "=" * 50)
    print("  Investor Profile Scoring - PostgreSQL")
    print("=" * 50)

    try:
        # Connect to database
        print("\n[1] Connecting to database...")
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cursor = conn.cursor()
        print("  ✓ Connected successfully!")

        # Drop existing tables (clean slate)
        print("\n[2] Cleaning existing tables...")
        cursor.execute(
            """
            DROP TABLE IF EXISTS investor_identification CASCADE;
            DROP TABLE IF EXISTS investor_nominee CASCADE;
            DROP TABLE IF EXISTS investor_bank CASCADE;
            DROP TABLE IF EXISTS investor CASCADE;
            DROP TABLE IF EXISTS scoring_rules CASCADE;
        """
        )
        print("  ✓ Tables cleaned")

        # Run SQL files
        print("\n[3] Running SQL scripts...")
        base_path = Path(__file__).parent
        for sql_file in SQL_FILES:
            run_sql_file(cursor, base_path / sql_file)

        # Test random code generator
        print("\n[4] Testing random code generator...")
        cursor.execute(
            "SELECT generate_random_number('INV', 'investor', 'investor_code', 10)"
        )
        result = cursor.fetchone()[0]
        print(f"  ✓ Generated code: {result}")

        # Run profile score query
        print("\n[5] Calculating profile scores...")
        with open(base_path / QUERY_FILE, "r") as f:
            query = f.read()
        cursor.execute(query)

        # Display results
        columns = [desc[0] for desc in cursor.description]
        rows = cursor.fetchall()

        print("\n" + "-" * 80)
        print(
            f"{'Investor':<12} {'Contact':<10} {'Photo':<8} {'Bank':<8} {'Nominee':<10} {'KYC':<8} {'Total':<10}"
        )
        print("-" * 80)

        for row in rows:
            print(
                f"{row[0]:<12} {row[1]:<10} {row[2]:<8} {row[3]:<8} {row[4]:<10} {row[5]:<8} {row[6]:<10}"
            )

        print("-" * 80)
        print("\n✓ Project executed successfully!")

        cursor.close()
        conn.close()

    except psycopg2.Error as e:
        print(f"\n✗ Database error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n✗ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
