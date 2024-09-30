-- CREATE EVN_average_customer_waiting_time_every_1_hour
SET GLOBAL event_scheduler = ON; --first make sure event scheduler is on
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    DECLARE avg_waiting_time INT;


    SELECT AVG(waiting_time_minutes) INTO avg_waiting_time
    FROM customer_service_ticket
    WHERE ticket_timestamp >= NOW() - INTERVAL 1 HOUR;

    
    INSERT INTO customer_service_kpi (customer_service_KPI_average_waiting_time_minutes)
    VALUES (avg_waiting_time);
END;