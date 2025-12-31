-- Core investor table
CREATE TABLE investor (
 investor_code VARCHAR(50) PRIMARY KEY,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 email VARCHAR(255),
 phone_number VARCHAR(50),
 photo TEXT,
 created_at TIMESTAMPTZ DEFAULT now()
);

-- Bank details
CREATE TABLE investor_bank (
 id BIGSERIAL PRIMARY KEY,
 investor_code VARCHAR(50),
 bank_name VARCHAR(200),
 account_no VARCHAR(100),
 ifsc VARCHAR(50),
 created_at TIMESTAMPTZ DEFAULT now()
);

-- Nominee details
CREATE TABLE investor_nominee (
 id BIGSERIAL PRIMARY KEY,
 investor_code VARCHAR(50),
 nominee_name VARCHAR(200),
 relation VARCHAR(100),
 created_at TIMESTAMPTZ DEFAULT now()
);

-- KYC documents
CREATE TABLE investor_identification (
 id BIGSERIAL PRIMARY KEY,
 investor_code VARCHAR(50),
 document_type VARCHAR(100),
 document_no VARCHAR(200),
 verified BOOLEAN DEFAULT FALSE,
 created_at TIMESTAMPTZ DEFAULT now()
);
