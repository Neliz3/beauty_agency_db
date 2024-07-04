delimiter //

CREATE PROCEDURE field_analysis ()
       BEGIN
            declare field_num int;
            declare service_num int;

            SELECT COUNT(field) INTO field_num FROM businesses;
            SELECT COUNT(id) INTO service_num FROM services;

       END//


CREATE FUNCTION CallProcedure(times INT) RETURNS INT
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= times DO
        CALL field_analysis();
        SET i = i + 1;
    END WHILE;
    RETURN CONCAT('FUNCTION WAS CALLED ', @i);
END //
