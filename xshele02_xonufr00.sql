ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

DROP TABLE Users CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Meeting CASCADE CONSTRAINTS;
DROP TABLE Car CASCADE CONSTRAINTS;
DROP TABLE Department_Head CASCADE CONSTRAINTS;
DROP TABLE Owner CASCADE CONSTRAINTS;
--DROP MATERIALIZED VIEW mv_customer_info;

-- Komentář k SQL kódu
-- Tabulka Users je základní entita, která obsahuje atributy společné pro všechny uživatele.
-- Tabulky Employee a Customer jsou specializované entity odvozené z entity Users a obsahují 
-- specifické atributy pro zaměstnance a zákazníky.
-- Tabulka Department_Head je další specializovaná entita odvozená z entity Employee a obsahuje 
-- specifické atributy pro vedoucí oddělení.
-- Tabulka Owner je další specializovaná entita odvozená z entity Employee a obsahuje 
-- specifické atributy pro vlastníky.
-- Tento vztah generalizace/specializace je realizován pomocí cizích klíčů, kde každá 
-- specializovaná entita má cizí klíč, který odkazuje na primární klíč entity Users.
-- Tímto způsobem je zajištěno, že každý zaměstnanec, zákazník, vedoucí oddělení nebo vlastník je také uživatelem.

CREATE TABLE Users (
    ID INTEGER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    login_name VARCHAR(20) NOT NULL,
    password_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    rc VARCHAR(11) NOT NULL,
    email VARCHAR(30),
    phone_number VARCHAR(15),
    PRIMARY KEY (ID),
    CONSTRAINT CK_RodneCislo CHECK (LENGTH(rc) = 11 AND REGEXP_LIKE(rc, '^\d{6}/\d{4}$'))
);


CREATE TABLE Customer (
    ID INTEGER NOT NULL,
    FOREIGN KEY (ID) REFERENCES Users(ID),
    CONSTRAINT PK_Customer PRIMARY KEY(ID)
);

CREATE TABLE Car(
    ID INTEGER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    model VARCHAR(50) NOT NULL,
    vin_code VARCHAR(17) NOT NULL,
    year_of_creating INTEGER NOT NULL,
    color VARCHAR(30) NOT NULL,
    
    CONSTRAINT PK_Car PRIMARY KEY (ID),
    CONSTRAINT CK_VINCode_Format CHECK (REGEXP_LIKE(vin_code, '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}[A-Z]{4}[0-9]{6}$'))
);

CREATE TABLE Employee (
    ID INTEGER NOT NULL,
    specialization VARCHAR(50),
    department VARCHAR(50),
    FOREIGN KEY (ID) REFERENCES Users(ID),
    PRIMARY KEY(ID)
);

CREATE TABLE Department_Head (
    ID INTEGER NOT NULL,
    position VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Employee(ID), 
    PRIMARY KEY(ID)
);

CREATE TABLE Owner (
    ID INTEGER NOT NULL,
    ownage VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID) REFERENCES Employee(ID), 
    PRIMARY KEY(ID)
);

CREATE TABLE Meeting(
    ID INTEGER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    Employee INTEGER NOT NULL,
    Customer INTEGER NOT NULL,
    place VARCHAR(30) NOT NULL,
    result VARCHAR(30) NOT NULL,
    
    CONSTRAINT PK_Meeting PRIMARY KEY (ID),
    CONSTRAINT FK_Meeting_Employee FOREIGN KEY (Employee) REFERENCES Employee(ID),
    CONSTRAINT FK_Meeting_Customer FOREIGN KEY (Customer) REFERENCES Customer(ID),
    CONSTRAINT CK_Meeting_Duration CHECK (end_time - start_time < INTERVAL '1' DAY)
);

INSERT INTO Users VALUES (DEFAULT, 'johndoe123', 'password123', 'John', 'Doe', '111111/2222', 'johndoe@example.com', '+1234567890');
INSERT INTO Users VALUES (DEFAULT, 'janesmith456', 'test456', 'Jane', 'Smith', '113151/2422', 'janesmith@example.com', '+1987654321');
INSERT INTO Users VALUES (DEFAULT, 'ajohnson789', '123test', 'Alex', 'Johnson','813171/2742', 'alex.johnson@example.com', '+1415926535');
INSERT INTO Users VALUES (DEFAULT, 'emilyb234', 'qwerty', 'Emily', 'Brown', '745125/9182', 'emilybrown@example.com', '+1239876543');
INSERT INTO Users VALUES (DEFAULT, 'mwilson777', 'passpass', 'Michael', 'Wilson', '453181/7452', 'mwilson@example.com', '+1555555555');
INSERT INTO Users VALUES (DEFAULT, 'staylorsarah', 'sarahpass', 'Sarah', 'Taylor', '125691/2372', 'staylor@example.com', '+1777888999');
INSERT INTO Users VALUES (DEFAULT, 'davemartinez1', 'david123', 'David', 'Martinez', '722581/7246', 'david.martinez@example.com', '+1666777888');
INSERT INTO Users VALUES (DEFAULT, 'oliviag789', 'garcia456', 'Olivia', 'Garcia', '128615/4333', 'olivia.garcia@example.com', '+1888777666');
INSERT INTO Users VALUES (DEFAULT, 'willrodz123', 'passpass', 'William', 'Rodriguez', '752145/5234', 'wrodriguez@example.com', '+1999444555');
INSERT INTO Users VALUES (DEFAULT, 'sophl456', 'lopezpass', 'Sophia', 'Lopez', '358741/1234', 'sophialopez@example.com', '+1444333222');


INSERT INTO Customer VALUES (3);
INSERT INTO Customer VALUES (4);
INSERT INTO Customer VALUES (6);
INSERT INTO Customer VALUES (7);
INSERT INTO Customer VALUES (8);


INSERT INTO CAR VALUES (DEFAULT, 'Rolls-Royce', 300000, 'Phantom', 'A11AA11AAAA111111', '2023', 'White');
INSERT INTO CAR VALUES (DEFAULT, 'Bentley', 250000, 'Flying Spur', 'B22BB22BBBB222222', '2023', 'Black');
INSERT INTO CAR VALUES (DEFAULT, 'Maybach', 350000, 'S-Class', 'C33CC33CCCC333333', '2023', 'Gold');
INSERT INTO CAR VALUES (DEFAULT, 'Lamborghini', 400000, 'Aventador', 'D44DD44DDDD444444', '2023', 'Red');
INSERT INTO CAR VALUES (DEFAULT, 'Toyota', 35000, 'Corolla', 'E55EE55EEEE555555', '2022', 'Gray');
INSERT INTO CAR VALUES (DEFAULT, 'Honda', 30000, 'Accord', 'F66FF66FFFF666666', '2023', 'Silver');
INSERT INTO CAR VALUES (DEFAULT, 'Ford', 50000, 'F-150', 'G77GG77GGGG777777', '2023', 'Blue');
INSERT INTO CAR VALUES (DEFAULT, 'Chrysler', 40000, 'Pacifica', 'H88HH88HHHH888888', '2023', 'Black');
INSERT INTO CAR VALUES (DEFAULT, 'Jeep', 45000, 'Wrangler', 'I99II99IIII999999', '2023', 'Green');
INSERT INTO CAR VALUES (DEFAULT, 'Land Rover', 60000, 'Range Rover', 'J12JJ34JJJJ567890', '2024', 'Black');


INSERT INTO Employee VALUES (1, 'passenger cars', 'Golden Dream, Prague');
INSERT INTO Employee VALUES (2, NULL, NULL);
INSERT INTO Employee VALUES (5, 'minivans', 'Black Rock, Brno');
INSERT INTO Employee VALUES (9, 'trucks', 'Black Rock, Brno');
INSERT INTO Employee VALUES (10, 'luxury cars', 'Golden Dream, Prague');

INSERT INTO Department_Head VALUES (5, 'head');
INSERT INTO Department_Head VALUES (10, 'head');

INSERT INTO Owner VALUES (2, 'owner');


INSERT INTO Meeting VALUES (DEFAULT, TO_TIMESTAMP('2024-03-20 09:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-20 10:00:00','YYYY-MM-DD HH24:MI:SS'), 1, 3, 'Conference Room A', 'Successful meeting');
INSERT INTO Meeting VALUES (DEFAULT, TO_TIMESTAMP('2024-03-20 10:00:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-20 11:00:00','YYYY-MM-DD HH24:MI:SS'), 2, 4, 'Conference Room B', 'Pending');

-- 1. Databázové triggery
CREATE OR REPLACE TRIGGER trg_Check_Car_Price
BEFORE INSERT OR UPDATE ON Car
FOR EACH ROW
BEGIN
    IF :NEW.price < 10000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'The price for car is too low.');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_Check_Meeting_Conflict
BEFORE INSERT ON Meeting
FOR EACH ROW
DECLARE
    Conflict_Count INTEGER;
BEGIN
    SELECT COUNT(*) INTO Conflict_Count
    FROM Meeting
    WHERE Employee = :NEW.Employee
    AND ((:NEW.start_time BETWEEN start_time AND end_time)
    OR (:NEW.end_time BETWEEN start_time AND end_time));

    IF Conflict_Count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employee already has a meeting scheduled for this time.');
    END IF;
END;

-- Kontrola
--INSERT INTO Meeting VALUES (DEFAULT, TO_TIMESTAMP('2024-03-20 09:30:00','YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-20 10:30:00','YYYY-MM-DD HH24:MI:SS'), 1, 3, 'Conference Room A', 'Successful meeting');
--INSERT INTO CAR VALUES (DEFAULT, 'Land Rover', 6000, 'Range Rover', 'J12JJ34JJJJ567890', '2022', 'Black');



-- 2. Uložené procedury
CREATE OR REPLACE PROCEDURE update_car_price(p_car_id Car.ID%TYPE, p_new_price Car.price%TYPE) AS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Car WHERE ID = p_car_id;
    
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Car with ID ' || p_car_id || ' does not exist.');
    END IF;
    
    UPDATE Car SET price = p_new_price WHERE ID = p_car_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error when updating the car price: ' || SQLERRM);
END;

-- DECLARE
--     v_car_id Car.ID%TYPE := 1; 
--     v_new_price Car.price%TYPE := 320000;
-- BEGIN
--     update_car_price(v_car_id, v_new_price); 
--     COMMIT; 
--     DBMS_OUTPUT.put_line('Price the car with ID ' || v_car_id || ' was successfully updated on ' || v_new_price);
-- EXCEPTION
--     WHEN OTHERS THEN
--         DBMS_OUTPUT.put_line('Error: ' || SQLERRM); 
-- END;

CREATE OR REPLACE PROCEDURE get_department_employees(
    p_department_name IN VARCHAR,
    p_cursor OUT SYS_REFCURSOR
)
IS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Employee WHERE department = p_department_name;
    
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Department with name ' || p_department_name || ' does not exist.');
    END IF;
    
    OPEN p_cursor FOR
        SELECT first_name, last_name, email
        FROM Users u
        JOIN Employee e ON u.ID = e.ID
        WHERE e.department = p_department_name;
END get_department_employees;


-- DECLARE
--     v_department_cursor SYS_REFCURSOR;
--     v_first_name Users.first_name%TYPE;
--     v_last_name Users.last_name%TYPE;
--     v_email Users.email%TYPE;
-- BEGIN
--     get_department_employees('Golden Dream, Prague', v_department_cursor);
--     LOOP
--         FETCH v_department_cursor INTO v_first_name, v_last_name, v_email;
--         EXIT WHEN v_department_cursor%NOTFOUND;
--         DBMS_OUTPUT.PUT_LINE('Zaměstnanec: ' || v_first_name || ' ' || v_last_name || ', E-mail: ' || v_email);
--     END LOOP;
--     CLOSE v_department_cursor;
-- END;


-- 3. Index
-- Vytvoření indexu na sloupec start_time
CREATE INDEX idx_meeting_start_time ON Meeting(start_time);

-- Dotaz, který využívá index pro optimalizaci
SELECT *
FROM Meeting
WHERE start_time >= TIMESTAMP '2024-03-20 08:00:00'
  AND start_time < TIMESTAMP '2024-03-20 10:00:00'
ORDER BY start_time;

-- 4. EXPLAIN PLAN

-- 1. zrychleni CREATE INDEX idx_meeting_employee ON Meeting(Employee);
-- 2. zrychleni CREATE INDEX idx_users_name ON Users(first_name, last_name);


EXPLAIN PLAN FOR
SELECT u.first_name || ' ' || u.last_name AS employee_name,
       COUNT(m.ID) AS meeting_count
FROM Users u
JOIN Meeting m ON u.ID = m.Employee
GROUP BY u.first_name, u.last_name;

--SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- 5. Přístupová práva
GRANT SELECT, INSERT, UPDATE ON Users TO XSHELE02;
GRANT SELECT ON Car TO XSHELE02;
GRANT SELECT ON Customer TO XSHELE02;

-- 6. Materializovaný pohled
CREATE MATERIALIZED VIEW mv_customer_info
AS SELECT U.first_name, U.last_name, U.email
FROM XONUFR00.USERS U
JOIN XONUFR00.CUSTOMER C ON U.ID = C.ID;

--SELECT * FROM mv_customer_info;

-- 7. Komplexní dotaz SELECT
WITH Employee_Specialization AS (
    SELECT E.ID, E.specialization, DH.position AS Position
    FROM Employee E
    LEFT JOIN Department_Head DH ON E.ID = DH.ID
    WHERE E.specialization IS NOT NULL
)
SELECT U.first_name, U.last_name,
       CASE
           WHEN ES.specialization IS NOT NULL THEN ES.specialization
           ELSE 'Without specialization'
       END AS Specialization,
       CASE
           WHEN ES.Position IS NOT NULL THEN ES.Position
           ELSE 'worker'
       END AS Position
FROM Employee_Specialization ES
JOIN Users U ON U.ID = ES.ID;

-- Tento dotaz získává data o zaměstnancích z tabulky Employee.
-- Pokud má zaměstnanec specifikovanou specializaci, zobrazí se tato specializace; 
-- v opačném případě se zobrazí "Without specialization". Stejně tak, pokud má zaměstnanec pozici, 
-- zobrazí se tato pozice(head); pokud nemá žádnou specifikovanou pozici, zobrazí se "worker". 
-- Jména zaměstnanců jsou získávána z tabulky Users.