CREATE DATABASE CarRentalDB;
USE CarRentalDB;

show databases; 

CREATE TABLE Customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Cars (
    car_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(60) NOT NULL,
    model VARCHAR(60) NOT NULL,
    year INT NOT NULL,
    type VARCHAR(30) NOT NULL
);

CREATE TABLE Rentals (
    rental_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    rental_date DATE NOT NULL,
    return_date DATE,
    rental_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Customers (first_name, last_name, date_of_birth, email) VALUES 
    ('John', 'Doe', '1980-01-01', 'john.doe@example.com'),
    ('Jane', 'Smith', '1990-02-15', 'jane.smith@example.com'),
    ('Alice', 'Johnson', '1985-03-20', 'alice.johnson@example.com'),
    ('Bob', 'Brown', '1978-04-25', 'bob.brown@example.com'),
    ('Charlie', 'Davis', '1992-05-30', 'charlie.davis@example.com');

INSERT INTO Cars (make, model, year, type) VALUES 
    ('Toyota', 'Camry', 2020, 'Sedan'),
    ('Honda', 'Civic', 2019, 'Sedan'),
    ('Ford', 'Mustang', 2021, 'Coupe'),
    ('Chevrolet', 'Tahoe', 2018, 'SUV'),
    ('BMW', 'X5', 2020, 'SUV');


INSERT INTO Rentals (customer_id, car_id, rental_date, return_date, rental_status) VALUES 
    (1, 1, '2024-01-10', '2024-01-15', 'Returned'),
    (2, 2, '2024-01-11', '2024-01-16', 'Returned'),
    (3, 3, '2024-01-12', NULL, 'Rented'),
    (4, 4, '2024-01-13', '2024-01-18', 'Returned'),
    (5, 5, '2024-01-14', NULL, 'Rented');
    
    SELECT first_name,last_name FROM Customers;
    
    SELECT * FROM Cars;
    
    SELECT * FROM Rentals;
    
    UPDATE Rentals SET rental_status = 'Returned', return_date = '2024-01-20' WHERE rental_id = 3;
    
CREATE VIEW CustomerRentalHistory AS
SELECT c.first_name, c.last_name, r.rental_date, r.return_date, r.rental_status, ca.make, ca.model
FROM Rentals r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Cars ca ON r.car_id = ca.car_id;

SELECT make, model, type,
    CASE 
        WHEN type = 'SUV' THEN 'Large'
        WHEN type = 'Sedan' THEN 'Medium'
        WHEN type = 'Coupe' THEN 'Small'
        ELSE 'Other'
    END AS size_category
FROM Cars;

DELIMITER $$

CREATE PROCEDURE AddRental(IN cust_id INT, IN car_id INT, IN rent_date DATE, IN ret_date DATE, IN status VARCHAR(20))
BEGIN
    INSERT INTO Rentals (customer_id, car_id, rental_date, return_date, rental_status) 
    VALUES (cust_id, car_id, rent_date, ret_date, status);
END$$

DELIMITER ;

CALL AddRental(2, 3, '2024-01-15', NULL, 'Rented');






    







