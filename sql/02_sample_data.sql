INSERT INTO investor VALUES
('INV001','Alice','Full','alice@example.com','9999000001','photo1.jpg',now()),
('INV002','Bob','NoPhone','bob@example.com',NULL,'photo2.jpg',now()),
('INV003','Carol','NoPhoto',NULL,'9999000003',NULL,now());

INSERT INTO investor_bank VALUES
(DEFAULT,'INV001','Bank A','1111','IFSC1',now());

INSERT INTO investor_nominee VALUES
(DEFAULT,'INV001','Spouse','Wife',now());

INSERT INTO investor_identification VALUES
(DEFAULT,'INV001','PAN','ABCDE1234F',TRUE,now());
