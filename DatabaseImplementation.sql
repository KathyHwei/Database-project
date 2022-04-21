-- insert-- 


insert into Departments(idDepartments, Department) values(2,"Stocker");
insert into Benefits(BenefitID, HealthCare, Discounts) values(2,"statefarm",.32);
insert into Supplier(idSupplier, supplier, email) values(3,"Rutgers", "RU@njit.edu");
insert into Customer(CustomerID, FirstName, LastName, Email, PhoneNumber, Benefits_BenefitID) values(1,'Kathy','Huang', 'cat@gmail.com', 9731233234, 2);
insert into Inventory(InventoryID, Manufacture, purchasedPrice, soldPrice, Supplier_idSupplier) values(12,"Rutgers",15,20, 3);
insert into Benefits(BenefitID, HealthCare, Discounts) values(1, 'StateFam', 0.25);
insert into Employee(idEmployee, FirstName, LastName, Departments_idDepartments, email, Benefits_BenefitID) values(1,"peter","jackson",2,"dogs@gmail.com", 1);

insert into InventoryTurnOver(OrderDetails_OrderDetailsID, Inventory_InventoryID, ReplacementRatio) values(2,3,11.2);
insert into Contract(contractID,expireDate,effectiveDate, Supplier_idSupplier) values(64,"Sept 29,1002","Dec 29,1920",1);

insert into Manages(Inventory_InventoryID, Departments_idDepartments, JobTask) values(3,12,"Dancer");
insert into OrderDetails(OrderDetailsID, Customer_CustomerID, TotalPrice, taxes, insuranceCost)	values(1,2,2.3,21.0,0.23);


-- update--
update Customer set FirstName ="Jerry" where CustomerID=1;

-- delete --
delete from Customer where CustomerID = 1;
insert into Customer(CustomerID,FirstName,LastName, Email, PhoneNumber,Benefits_BenefitID) values(1,'Jim','larry', 'puppy@gmail.com', 973-555-5555,1);

-- truncate --
truncate table Customer;
insert into Customer(CustomerID,FirstName,LastName, Email, PhoneNumber,Benefits_BenefitID) values(1,'Jim','larry', 'puppy@gmail.com', 973-555-5555,1);

-- multi tables--
-- left outer join-- + orderBY nope
insert into Employee(idEmployee, FirstName, LastName, Departments_idDepartments, email, Benefits_BenefitID) values(2,"jim","jackson",1,"god@gmail.com", 1);

SELECT Customer.FirstName, Benefits.BenefitID
FROM Customer
LEFT Outer JOIN Benefits
ON Customer.CustomerID=Benefits.BenefitID
ORDER BY Customer.FirstName;

-- right outer join -- + orderBY 
SELECT Customer.FirstName, Benefits.BenefitID
FROM Customer
RIGHT Outer JOIN Benefits
ON Customer.CustomerID=Benefits.BenefitID
ORDER BY Customer.FirstName;

-- aggregate functions --
-- sum()-- 
insert into Inventory(InventoryID, Manufacture, purchasedPrice, soldPrice, Supplier_idSupplier) values(2,"CNN",14,2, 3);
select min(CustomerID) from Customer;

-- max()--
insert into Inventory(InventoryID, Manufacture, purchasedPrice, soldPrice, Supplier_idSupplier) values(3,"KFC",14,5, 21);
select max(InventoryID) from Inventory;

-- min()--
select min(InventoryID) from Inventory;

-- where-- + -- groupBY -- 
insert into Inventory(InventoryID, Manufacture, purchasedPrice, soldPrice, Supplier_idSupplier) values(4,"ANC",14,2, 20);

SELECT Manufacture, soldPrice
FROM Inventory
WHERE soldPrice <10
GROUP BY soldPrice;

-- having --
SELECT COUNT(InventoryID), soldPrice
FROM Inventory
GROUP BY soldPrice
HAVING COUNT(soldPrice) < 5;

-- OrderBy--
SELECT * FROM Inventory
ORDER BY soldPrice DESC;

-- between --
SELECT soldPrice
FROM Inventory
WHERE soldPrice BETWEEN 1 AND 10;

-- drop database inventorymanagement; -- deletes the whole datanbase