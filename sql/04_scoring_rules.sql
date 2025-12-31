CREATE TABLE scoring_rules (
 rule_key TEXT PRIMARY KEY,
 weight INT NOT NULL
);

INSERT INTO scoring_rules VALUES
('contact_email', 10),
('contact_phone', 10),
('photo', 20),
('bank', 20),
('nominee', 20),
('kyc_verified', 20),
('kyc_unverified', 10);
