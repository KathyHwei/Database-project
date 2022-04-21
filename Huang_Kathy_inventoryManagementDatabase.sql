-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema InventoryManagement
-- -----------------------------------------------------
-- For database final project!

-- -----------------------------------------------------
-- Schema InventoryManagement
--
-- For database final project!
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `InventoryManagement` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `InventoryManagement` ;

-- -----------------------------------------------------
-- Table `InventoryManagement`.`Benefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Benefits` (
  `BenefitID` INT NOT NULL AUTO_INCREMENT,
  `HealthCare` VARCHAR(45) NOT NULL,
  `Discounts` FLOAT NOT NULL,
  PRIMARY KEY (`BenefitID`),
  UNIQUE INDEX `idlocation_UNIQUE` (`BenefitID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  `Benefits_BenefitID` INT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC),
  UNIQUE INDEX `Customercol_UNIQUE` (`PhoneNumber` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  INDEX `fk_Benefits_BenefitID_idx` (`Benefits_BenefitID` ASC),
  CONSTRAINT `fk_Benefits_BenefitID`
    FOREIGN KEY (`Benefits_BenefitID`)
    REFERENCES `InventoryManagement`.`Benefits` (`BenefitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Departments` (
  `idDepartments` INT NOT NULL AUTO_INCREMENT,
  `Department` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDepartments`),
  UNIQUE INDEX `idDepartments_UNIQUE` (`idDepartments` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Departments_idDepartments` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `Benefits_BenefitID` INT NULL,
  PRIMARY KEY (`idEmployee`),
  UNIQUE INDEX `idEmployee_UNIQUE` (`idEmployee` ASC),
  INDEX `fk_Employee_Departments1_idx` (`Departments_idDepartments` ASC),
  INDEX `fk_Employee_location1_idx` (`Benefits_BenefitID` ASC),
  CONSTRAINT `fk_Employee_Departments1`
    FOREIGN KEY (`Departments_idDepartments`)
    REFERENCES `InventoryManagement`.`Departments` (`idDepartments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_location1`
    FOREIGN KEY (`Benefits_BenefitID`)
    REFERENCES `InventoryManagement`.`Benefits` (`BenefitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Supplier` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT,
  `supplier` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE INDEX `supplier_UNIQUE` (`supplier` ASC),
  UNIQUE INDEX `idSupplier_UNIQUE` (`idSupplier` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Inventory` (
  `InventoryID` INT NOT NULL AUTO_INCREMENT,
  `Manufacture` VARCHAR(45) NOT NULL,
  `purchasedPrice` FLOAT NOT NULL,
  `soldPrice` FLOAT NOT NULL,
  `Supplier_idSupplier` INT NOT NULL,
  PRIMARY KEY (`InventoryID`),
  INDEX `fk_Inventory_Supplier1_idx` (`Supplier_idSupplier` ASC),
  CONSTRAINT `fk_Inventory_Supplier1`
    FOREIGN KEY (`Supplier_idSupplier`)
    REFERENCES `InventoryManagement`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`OrderDetails` (
  `OrderDetailsID` INT NOT NULL AUTO_INCREMENT,
  `Customer_CustomerID` INT NOT NULL,
  `TotalPrice` FLOAT NOT NULL,
  `taxes` FLOAT NOT NULL,
  `insuranceCost` FLOAT NOT NULL,
  PRIMARY KEY (`OrderDetailsID`),
  INDEX `fk_OrderDetails_Customer1_idx` (`Customer_CustomerID` ASC),
  CONSTRAINT `fk_OrderDetails_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `InventoryManagement`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Manages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Manages` (
  `Inventory_InventoryID` INT NOT NULL,
  `Departments_idDepartments` INT NOT NULL,
  `JobTask` VARCHAR(45) NOT NULL,
  INDEX `fk_Works_Inventory1_idx` (`Inventory_InventoryID` ASC),
  INDEX `fk_Works_Departments1_idx` (`Departments_idDepartments` ASC),
  PRIMARY KEY (`Inventory_InventoryID`, `Departments_idDepartments`),
  CONSTRAINT `fk_Works_Inventory1`
    FOREIGN KEY (`Inventory_InventoryID`)
    REFERENCES `InventoryManagement`.`Inventory` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Works_Departments1`
    FOREIGN KEY (`Departments_idDepartments`)
    REFERENCES `InventoryManagement`.`Departments` (`idDepartments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`InventoryTurnOver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`InventoryTurnOver` (
  `OrderDetails_OrderDetailsID` INT NOT NULL,
  `Inventory_InventoryID` INT NOT NULL,
  `ReplacementRatio` FLOAT NOT NULL,
  INDEX `fk_inventoryTurnOver_OrderDetails1_idx` (`OrderDetails_OrderDetailsID` ASC),
  INDEX `fk_inventoryTurnOver_Inventory1_idx` (`Inventory_InventoryID` ASC),
  PRIMARY KEY (`OrderDetails_OrderDetailsID`, `Inventory_InventoryID`),
  CONSTRAINT `fk_inventoryTurnOver_OrderDetails1`
    FOREIGN KEY (`OrderDetails_OrderDetailsID`)
    REFERENCES `InventoryManagement`.`OrderDetails` (`OrderDetailsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventoryTurnOver_Inventory1`
    FOREIGN KEY (`Inventory_InventoryID`)
    REFERENCES `InventoryManagement`.`Inventory` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryManagement`.`Contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InventoryManagement`.`Contract` (
  `contractID` INT NOT NULL AUTO_INCREMENT,
  `expireDate` VARCHAR(45) NOT NULL,
  `effectiveDate` VARCHAR(45) NOT NULL,
  `Supplier_idSupplier` INT NOT NULL,
  UNIQUE INDEX `contractID_UNIQUE` (`contractID` ASC),
  INDEX `fk_Contract_Supplier1_idx` (`Supplier_idSupplier` ASC),
  PRIMARY KEY (`contractID`),
  CONSTRAINT `fk_Contract_Supplier1`
    FOREIGN KEY (`Supplier_idSupplier`)
    REFERENCES `InventoryManagement`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
