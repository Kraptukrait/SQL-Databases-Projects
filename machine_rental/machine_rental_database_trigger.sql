
DELIMITER $$  
CREATE TRIGGER tr_machine_type_cost_up  
BEFORE UPDATE  
ON tbl_machine_type  
FOR EACH ROW  
BEGIN  
    INSERT INTO tbl_machine_type_copy (pk_type, machine_category, manufacturer, license_required, workshop, rate_per_day, rate_per_km, update_time)  
    VALUES (OLD.pk_type, OLD.machine_category, OLD.manufacturer, OLD.license_required, OLD.workshop, OLD.rate_per_day, OLD.rate_per_km, NOW());  
END$$  
DELIMITER ;

DELIMITER $$  
CREATE TRIGGER tr_machine_type_cost_del  
BEFORE DELETE  
ON tbl_machine_type  
FOR EACH ROW  
BEGIN  
    INSERT INTO tbl_machine_type_copy (pk_type, machine_category, manufacturer, license_required, workshop, rate_per_day, rate_per_km, update_time)  
    VALUES (OLD.pk_type, OLD.machine_category, OLD.manufacturer, OLD.license_required, OLD.workshop, OLD.rate_per_day, OLD.rate_per_km, NOW());  
END$$  
DELIMITER ;

DELIMITER $$  
CREATE TRIGGER tr_machine_type_cost_ins  
BEFORE INSERT  
ON tbl_machine_type  
FOR EACH ROW  
BEGIN  
    INSERT INTO tbl_machine_type_copy (pk_type, machine_category, manufacturer, license_required, workshop, rate_per_day, rate_per_km, update_time)  
    VALUES (NEW.pk_type, NEW.machine_category, NEW.manufacturer, NEW.license_required, NEW.workshop, NEW.rate_per_day, NEW.rate_per_km, NOW());  
END$$  
DELIMITER ;
