-- Tạo users trên CSDL classicmodels
USE classicmodels;
CREATE USER 
	'dianemurphy'@'localhost' IDENTIFIED BY '1231',
	'marypatterson'@'localhost' IDENTIFIED BY '1232',
    'jefffirrelli'@'localhost' IDENTIFIED BY '1233',
    'williampatterson'@'localhost' IDENTIFIED BY '1234',
    'gerardbondur'@'localhost' IDENTIFIED BY '1235',
    'anthonybow'@'localhost' IDENTIFIED BY '1236',
    'lesliejennings'@'localhost' IDENTIFIED BY '1237',
    'lesliethompson'@'localhost' IDENTIFIED BY '1238',
    'juliefirrelli'@'localhost' IDENTIFIED BY '1239',
    'stevepatterson'@'localhost' IDENTIFIED BY '1240',
    'foonyuetseng'@'localhost' IDENTIFIED BY '1241',
    'georgevanauf'@'localhost' IDENTIFIED BY '1242',
    'louibondur'@'localhost' IDENTIFIED BY '1243',
    'gerardhernandez'@'localhost' IDENTIFIED BY '1244',
    'pamelacastillo'@'localhost' IDENTIFIED BY '1245',
    'larrybott'@'localhost' IDENTIFIED BY '1246',
    'barryjones'@'localhost' IDENTIFIED BY '1247',
    'andyfixter'@'localhost' IDENTIFIED BY '1248',
    'petermarsh'@'localhost' IDENTIFIED BY '1249',
    'tomking'@'localhost' IDENTIFIED BY '1250',
    'maminishi'@'localhost' IDENTIFIED BY '1251',
    'yoshimikato'@'localhost' IDENTIFIED BY '1252',
    'martingerard'@'localhost' IDENTIFIED BY '1253';
    
-- Tạo các roles trên CSDL classicmodels
USE classicmodels;
CREATE ROLE
	classicmodels_salesvicepresident@'localhost',
    classicmodels_salesmanager@'localhost',
    classicmodels_salesrep@'localhost';


-- Phân quyền cho các roles trên CSDL classicmodels
USE classicmodels;

-- Role cho các VP bộ phận Sales, Marketing
GRANT ALL ON classicmodels.orders TO classicmodels_salesvicepresident@'localhost';
GRANT ALL ON classicmodels.orderdetails TO classicmodels_salesvicepresident@'localhost';
GRANT ALL ON classicmodels.payments TO classicmodels_salesvicepresident@'localhost';

-- Role cho các sales manager bộ phận Sales
GRANT SELECT, INSERT, UPDATE, DELETE 
ON classicmodels.orders TO classicmodels_salesmanager@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE 
ON classicmodels.orderdetails TO classicmodels_salesmanager@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE 
ON classicmodels.payments TO classicmodels_salesmanager@'localhost';

-- Role cho các nhân viên bộ phận Sales
GRANT SELECT ON classicmodels.orders TO classicmodels_salesrep@'localhost';
GRANT SELECT ON classicmodels.orderdetails TO classicmodels_salesrep@'localhost';
GRANT SELECT ON classicmodels.payments TO classicmodels_salesrep@'localhost';


-- Phân quyền và gán roles cho các user accounts trên CSDL classicmodels
-- Diane Murphy được phép truy cập toàn bộ database
GRANT ALL ON *.* TO 'dianemurphy'@'localhost';

-- Gán SalesVicePresident role cho các user
USE classicmodels;

GRANT classicmodels_salesvicepresident@'localhost' 
TO 'marypatterson'@'localhost', 'jefffirrelli'@'localhost';

-- Gán SalesManager role cho các user 
GRANT classicmodels_salesmanager@'localhost'
TO 'williampatterson'@'localhost', 'gerardbondur'@'localhost', 'anthonybow'@'localhost';

-- Gán SalesRep role cho các user
GRANT classicmodels_salesrep@'localhost'
TO 'lesliejennings'@'localhost', 'lesliethompson'@'localhost', 'juliefirrelli'@'localhost',
'stevepatterson'@'localhost', 'foonyuetseng'@'localhost', 'georgevanauf'@'localhost',
'louibondur'@'localhost', 'gerardhernandez'@'localhost', 'pamelacastillo'@'localhost',
'larrybott'@'localhost', 'barryjones'@'localhost', 'andyfixter'@'localhost', 'petermarsh'@'localhost',
'tomking'@'localhost', 'maminishi'@'localhost', 'yoshimikato'@'localhost', 'martingerard'@'localhost';

-- Kích hoạt role để user có thể thể kết nối tới database server
SET DEFAULT ROLE ALL TO 
'marypatterson'@'localhost', 'jefffirrelli'@'localhost', 'williampatterson'@'localhost', 'gerardbondur'@'localhost', 
'anthonybow'@'localhost', 'lesliejennings'@'localhost', 'lesliethompson'@'localhost', 'juliefirrelli'@'localhost', 
'stevepatterson'@'localhost', 'foonyuetseng'@'localhost', 'georgevanauf'@'localhost', 'louibondur'@'localhost', 
'gerardhernandez'@'localhost', 'pamelacastillo'@'localhost','larrybott'@'localhost', 'barryjones'@'localhost', 
'andyfixter'@'localhost', 'petermarsh'@'localhost', 'tomking'@'localhost', 'maminishi'@'localhost', 
'yoshimikato'@'localhost', 'martingerard'@'localhost';