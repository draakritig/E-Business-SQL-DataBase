--Creating comm_customers table--
CREATE TABLE comm_customers
(Customer_id NUMBER(3),
Customer_lname VARCHAR2(10) NOT NULL,
Customer_fname VARCHAR2(10) NOT NULL,
Contact NUMBER(12),
Email VARCHAR2(20),
Address VARCHAR2(20),
City VARCHAR2(12),
State VARCHAR2(2),
Zip VARCHAR2(6),
REGION CHAR(2),
Billing_address VARCHAR2(20),
Billing_city VARCHAR2(12),
Billing_state VARCHAR2(2),
Billing_zip VARCHAR2(6),
Billing_region CHAR(2),
 CONSTRAINT cust_customer_id_pk PRIMARY KEY(Customer_id),
 CONSTRAINT comm_customers_region_ck
                CHECK (region IN ('N', 'NW', 'NE', 'S', 'SE', 'SW', 'W', 'E')),
CONSTRAINT cust_billing_region_ck
                CHECK (Billing_region IN ('N', 'NW', 'NE', 'S', 'SE', 'SW', 'W', 'E')));

--Inserting values in comm_customers table-- 
INSERT INTO COMM_CUSTOMERS
VALUES (101, 'SMYTHE', 'TOM', 4657788890, 'TSMYTHE@GMAIL.COM','4506 FULLMOON CR', 
'MISSISSAUGA','ON','L4Z2K8', 'N','456 TRAFALGAR ROAD','OAKVILLE','ON','L6J7X1','N');
INSERT INTO COMM_CUSTOMERS
VALUES (102,'WILLIAMS','DAN',7094372400,'DEWL@YANDEX.COM','115 TIANALEE CRES',
'BRAMPTON','ON','L7A2K8','NE','115 TIANALEE CRES','BRAMPTON','ON','L7A2K8','NE');
INSERT INTO COMM_CUSTOMERS
VALUES (103,'VEZINA','DOMINIC',4509914012,'DOMVEZ91@GMAIL.COM','1102 LYCEE CLAUDAL',
'OTTAWA','ON','K1G4A7','SE','1102 LYCEE CLAUDAL','OTTAWA','ON','K1G4A7','SE');
INSERT INTO COMM_CUSTOMERS
VALUES (104,'JOHNSON','BERRY',4039335250,'JBERRY@YANDEX.COM','5014 INGLEWOOD DR',
'WESTASKIWIN','AB','T9A3R7','S','141 CLAIRE DR','NANAIMO','BC','V9S3E2','NW');
INSERT INTO COMM_CUSTOMERS
VALUES (105,'FREESON','HARRY',7806963793,'HF12@GMAIL.COM','P.O. BOX 21',
'BRETON','AB','T4H5A7','E','P.O. BOX 21','BRETON','AB','T4H5A7','E');

--Creating comm_shoeorder table--
CREATE TABLE comm_shoeorder
(Order_id VARCHAR2(4),
Customer_id NUMBER(3),
Order_date DATE NOT NULL,
Ship_date DATE,
Ship_street VARCHAR2(20),
Ship_city VARCHAR2(13),
Ship_state VARCHAR2(2),
Ship_zip VARCHAR2(6),
Ship_cost NUMBER(4,2),
Ship_status VARCHAR2(12),
CONSTRAINT shord_order_id_pk PRIMARY KEY (Order_id),
 CONSTRAINT shord_cust_id_fk FOREIGN KEY (Customer_id)
 REFERENCES COMM_CUSTOMERS(Customer_id));

--Inserting values in comm_shoeorder table--
INSERT INTO comm_shoeorder
VALUES ('O001',101,'30-JAN-20','03-FEB-20','4506 FULLMOON CR','MISSISSAUGA','ON','L4Z2K8',5.00,'SHIPPED');
INSERT INTO comm_shoeorder
VALUES ('O002',102,'14-MAR-20','17-MAR-20','R1 PEIDMONT','MISSOURI','MO','63957',3.00,'SHIPPED');
INSERT INTO comm_shoeorder
VALUES ('O003',103,'05-MAY-20','09-MAY-20','1102 LYCEE CLAUDAL','OTTAWA','ON','K1G4A7',6.00,'SHIPPED');
INSERT INTO comm_shoeorder
VALUES ('O004',104,'08-AUG-20','NULL','2919 CHELSEA DR','FLORIDA','FL','33420',7.00,'INTRANSIT');
INSERT INTO comm_shoeorder
VALUES ('O005',105,'10-AUG-20',NULL,'P.O. BOX 21','BRETON','AB','T4H5A7',3.00,'INTRANSIT');

--Creating comm_cart table--
CREATE TABLE comm_cart
(Cart_id VARCHAR2(4),
Order_id VARCHAR2(4),
Shoe_id VARCHAR2(6),
Order_quantity NUMBER(3),
Order_payment NUMBER(5,2),
Status VARCHAR2(15),
CONSTRAINT coca_cart_id_pk PRIMARY KEY (Cart_id),
 CONSTRAINT coca_ord_id_fk FOREIGN KEY (Order_id)
 REFERENCES COMM_SHOEORDER(Order_id),
 CONSTRAINT comcar_quantity_ck CHECK (Order_quantity > 0));

--Inserting values in comm_cart table--
INSERT INTO comm_cart
VALUES('C000','O001','SS8011',2,45.95,'CHECKED OUT');
INSERT INTO comm_cart
VALUES('C111','O002','SS8012',1,19.45,'CHECKED OUT');
INSERT INTO comm_cart
VALUES('C222','O003','SS8013',3,77.90,'CHECKED OUT');
INSERT INTO comm_cart
VALUES('C333','O004','SS8014',1,20.15,'NOT CHECKED OUT');
INSERT INTO comm_cart
VALUES('C444','O005','SS8015',4,76.60,'NOT CHECKED OUT');

--Creating comm_category table--
CREATE TABLE comm_category
(Category_id NUMBER(2),
Category_name VARCHAR2(18),
Active CHAR(2),
CONSTRAINT comcat_cat_id_pk PRIMARY KEY (Category_id));

--Inserting values in comm_category table--
--Active column (instock or out of stock)- A for ACTIVE and NA for NON-ACTIVE
INSERT INTO comm_category
VALUES(11,'CANVAS','A');
INSERT INTO comm_category
VALUES(12,'SNEAKERS','A');
INSERT INTO comm_category
VALUES(13,'BOOTS','A');
INSERT INTO comm_category
VALUES(14,'BROGUES','NA');
INSERT INTO comm_category
VALUES(15,'CHELSEAS','NA');
INSERT INTO comm_category
VALUES(16,'MONKSTRAPS','A');
INSERT INTO comm_category
VALUES(17,'OXFORDS','NA');

--Creating comm_shoes table--
CREATE TABLE comm_shoes
(Shoe_id VARCHAR2(6),
Category_id NUMBER(2),
Color VARCHAR2(10),
shoe_size NUMBER(2,1),
stock NUMBER(4),
Price NUMBER(5,2),
Discount NUMBER(2,2),
Active CHAR(2),
CONSTRAINT comsho_shoe_id_pk PRIMARY KEY (Shoe_id),
 CONSTRAINT comsho_cat_id_fk FOREIGN KEY (Category_id)
 REFERENCES COMM_CATEGORY(Category_id));
 
--Inserting values in comm_shoes table--
--Active column (instock or out of stock)- A for ACTIVE and NA for NON-ACTIVE
 INSERT INTO comm_shoes
 VALUES('SS8011',11,'BROWN',7.5,10,19.95,0.1,'A');
 INSERT INTO comm_shoes
 VALUES('SS8012',12,'BLACK',9,20,24.55,NULL,'A');
 INSERT INTO comm_shoes
 VALUES('SS8013',13,'TAN',6.5,6,14.55,0.12,'A');
 INSERT INTO comm_shoes
 VALUES('SS8014',14,'WHITE',8,NULL,20.05,NULL,'NA');
 INSERT INTO comm_shoes
 VALUES('SS8015',15,'BLUE',7,NULL,30.45,0.2,'NA');

--Creating comm_supplier table--
CREATE TABLE comm_supplier
(Supplier_id VARCHAR2(3),
Brand_name VARCHAR2(20),
Supplier_Lname VARCHAR2(20),
Supplier_Fname VARCHAR2(20),
Supplier_contact NUMBER(12),
Supplier_email VARCHAR2(20),
Supplier_address VARCHAR2(20),
Supplier_city VARCHAR2(13),
Supplier_state VARCHAR2(2),
Supplier_zip VARCHAR2(6),
CONSTRAINT comsup_supl_id_pk PRIMARY KEY (Supplier_id));

--Inserting values in comm_supplier table--
INSERT INTO comm_supplier
VALUES('A01','SKETCHERS','THOMAS','SAMUEL',4567773889,'TSAM@GMAIL.COM','150 AIRPORT RD','LOUISIANA','LA','71449');
INSERT INTO comm_supplier
VALUES('A02','ARMOUR','BRADY','JUDY',9057879009,'JUDYB@GMAIL.COM','135 ALDO DRIVE','MISSISSAUGA','ON','L4Z7K9');
INSERT INTO comm_supplier
VALUES('A03','NIKE','BRADNER','ALEXANDER',3182568120,'ALEXBR@YANDEX.COM','610 SAMMY LN','ARKANSAS','AR','72830');
INSERT INTO comm_supplier
VALUES('A04','REEBOK','BROWN','CHRISTY',4576563080,'CBROWN@GMAIL.COM','105 OWL LN','VANCOUVER','BC','V1H7A9');
INSERT INTO comm_supplier
VALUES('A05','ADIDAS','SMITH','LINCOLN',9195639484,'SMITHL@GMAIL.COM','123 HOLMES LN','FLORIDA','FL','32113');
