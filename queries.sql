-- #list of restaurants
SELECT * FROM restaurants;

-- At any point of time, how many delivery persons are free to assign a duty
SELECT COUNT(*) FROM delivery_persons
 WHERE id NOT IN 
 (SELECT delivery_person_id FROM deliveries WHERE delivery_status = false);

-- What's the average no. of deliveries happening in a day
SELECT COUNT(*) FROM deliveries 
WHERE delivery_date = CURRENT_DATE;

-- Total number of orders delivered for each restaurant
SELECT restaurant_id, COUNT(*) FROM deliveries
 GROUP BY restaurant_id;

-- At any time, we should be able to see the total number of orders delivered for each restaurant distributed by delivery person
SELECT delivery_person_id, restaurant_id, COUNT(*) FROM deliveries 
GROUP BY delivery_person_id, restaurant_id;

-- If all shared partners are utilized right now, how soon can a restaurants be assigned a partner
SELECT MIN(estimated_time) FROM deliveries
 WHERE delivery_status = false;

-- Which is the most active period of the year, breaks down according to food outlets.
SELECT restaurant_id,delivery_date, COUNT(*) FROM deliveries 
WHERE delivery_date BETWEEN '2022-01-01' AND '2022-12-31' 
GROUP BY restaurant_id;

-- Create Statics about delivery partner performance (per day/week/month)
SELECT delivery_person_id, delivery_date, COUNT(*) FROM deliveries
 WHERE delivery_date BETWEEN '2022-01-01' AND '2022-12-31'
  GROUP BY delivery_person_id;

-- Should be able to search for a delivery partner using his name or phone number or order id assigned to him in one query.
SELECT * FROM delivery_persons 
WHERE delivery_person_name = 'John' OR delivery_person_phone = '1234567890'
 OR id IN (SELECT delivery_person_id FROM deliveries WHERE order_id = 1);

-- How many deliveries were performed and its success rate.
SELECT COUNT(*), delivery_status
 FROM deliveries 
 GROUP BY delivery_status;
