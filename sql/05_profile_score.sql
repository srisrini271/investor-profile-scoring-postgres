/*
Calculates investor profile score dynamically
No hardcoded values
*/

WITH base AS (
 SELECT
  i.investor_code,
  (i.email IS NOT NULL)::INT AS has_email,
  (i.phone_number IS NOT NULL)::INT AS has_phone,
  (i.photo IS NOT NULL)::INT AS has_photo,
  EXISTS (SELECT 1 FROM investor_bank b WHERE b.investor_code=i.investor_code) AS has_bank,
  EXISTS (SELECT 1 FROM investor_nominee n WHERE n.investor_code=i.investor_code) AS has_nominee,
  MAX(CASE WHEN id.verified THEN 1 ELSE 0 END) AS verified_kyc,
  MAX(CASE WHEN NOT id.verified THEN 1 ELSE 0 END) AS unverified_kyc
 FROM investor i
 LEFT JOIN investor_identification id
   ON id.investor_code=i.investor_code
 GROUP BY i.investor_code, i.email, i.phone_number, i.photo
)
SELECT
 investor_code,
 has_email*(SELECT weight FROM scoring_rules WHERE rule_key='contact_email')
 + has_phone*(SELECT weight FROM scoring_rules WHERE rule_key='contact_phone')
 AS contact_score,
 has_photo*(SELECT weight FROM scoring_rules WHERE rule_key='photo') AS photo_score,
 has_bank::INT*(SELECT weight FROM scoring_rules WHERE rule_key='bank') AS bank_score,
 has_nominee::INT*(SELECT weight FROM scoring_rules WHERE rule_key='nominee') AS nominee_score,
 CASE
  WHEN verified_kyc=1 THEN (SELECT weight FROM scoring_rules WHERE rule_key='kyc_verified')
  WHEN unverified_kyc=1 THEN (SELECT weight FROM scoring_rules WHERE rule_key='kyc_unverified')
  ELSE 0
 END AS kyc_score,
 (
   has_email*(SELECT weight FROM scoring_rules WHERE rule_key='contact_email')
 + has_phone*(SELECT weight FROM scoring_rules WHERE rule_key='contact_phone')
 + has_photo*(SELECT weight FROM scoring_rules WHERE rule_key='photo')
 + has_bank::INT*(SELECT weight FROM scoring_rules WHERE rule_key='bank')
 + has_nominee::INT*(SELECT weight FROM scoring_rules WHERE rule_key='nominee')
 + CASE
    WHEN verified_kyc=1 THEN (SELECT weight FROM scoring_rules WHERE rule_key='kyc_verified')
    WHEN unverified_kyc=1 THEN (SELECT weight FROM scoring_rules WHERE rule_key='kyc_unverified')
    ELSE 0
   END
 ) || '/100' AS total_score
FROM base
ORDER BY investor_code;
