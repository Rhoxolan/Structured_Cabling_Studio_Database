INSERT INTO IsolationTypeRecommendations VALUES
('Indoor', 'Indoor'),
('Outdoor', 'Outdoor')

INSERT INTO IsolationMaterialRecommendations VALUES
('LSZH', 'LSZH, LSOH, LSHF, LSNH, NHFR, HFFR, FRZH, LSFRZH'),
('PVC', 'PVC, PP, PE')

INSERT INTO ShieldedTypeRecommendations VALUES
('FTP', 'FTP, STP, F/UTP, S/UTP, U/FTP, SF/UTP, F/FTP, S/FTP, SF/FTP'),
('UTP', 'UTP (U/UTP)')

INSERT INTO CableStandardRecommendations VALUES
('TenBASE_T', 1, '3 (Cat 3), 5 (Cat 5), 5e (Cat 5e)'),
('FastEthernet', 2, '5 (Cat 5), 5e (Cat 5e)'),
('GigabitBASE_T', 3, '5e (Cat 5e)'),
('GigabitBASE_TX', 4, '6 (Cat 6)'),
('TwoPointFiveGBASE_T', 5, '5e (Cat 5e)'),
('FiveGBASE_T', 6, '6 (Cat 6)'),
('TenGE', 7, '6 (Cat 6), 7 (Cat 7), 7a (Cat 7a)')