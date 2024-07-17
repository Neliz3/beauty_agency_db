delimiter //

drop procedure field_analysis;
CREATE procedure field_analysis (out field_num int, out service_num int)
       BEGIN
            SELECT COUNT(field) INTO field_num FROM businesses;
            SELECT COUNT(id) INTO service_num FROM services;
       END//


drop function ChangeDate;
CREATE FUNCTION ChangeDate(date_row date) RETURNS VARCHAR(10)
    DETERMINISTIC
BEGIN
    DECLARE formatted_date VARCHAR(10);
    set formatted_date = DATE_FORMAT(date_row, '%d.%m.%y');
    RETURN formatted_date;
END //

/*select ChangeDate(order_date) from orders;*/
