SELECT card, ROUND(AVG(amount)) AS "Average Card Activity Amount"
	FROM transaction 
	GROUP BY card
	ORDER BY "Average Card Activity Amount" DESC;
	
-- JOIN card_holder and credit_card
SELECT cardholder_id, card
  FROM credit_card JOIN  card_holder
	ON credit_card.cardholder_id = card_holder.id;
 
--JOIN credit card with card_holder

SELECT name, id
	FROM card_holder JOIN credit_card 
	ON card_holder.id = credit_card.cardholder_id;

-- Sub Query to get credit card and amount 

SELECT card, amount, date
FROM transaction

WHERE card IN 
(
	SELECT card
	FROM credit_card
	WHERE id IN
  (
	SELECT id
	FROM card_holder
	  )
);


-- Join and Group by 5 Databases (t.cc.ch.m.mc)

SELECT ch.name, t.date, t.amount, t.card, cc.cardholder_id AS "cc_id", cc.card  AS "Credit Card", t.id_merchant, m.name AS "Merchant", 
mc.name AS "merchant category"
FROM transaction AS t
	JOIN credit_card AS cc 
	ON (t.card = cc.card)
		JOIN card_holder AS ch
		ON (cc.cardholder_id = ch.id)
			JOIN merchant AS m
			ON (t.id_merchant = m.id)
				JOIN merchant_category AS mc
				ON (m.id_merchant_category = mc.id);

-- Create View for Total Transactions
--DROP VIEW total_transactions;


CREATE VIEW total_transactions AS
SELECT ch.name, t.date, t.amount, t.card, cc.cardholder_id AS "cc_id", cc.card  AS "Credit Card", t.id_merchant, m.name AS "Merchant", 
mc.name AS "merchant category"
FROM transaction AS t
	JOIN credit_card AS cc 
	ON (t.card = cc.card)
		JOIN card_holder AS ch
		ON (cc.cardholder_id = ch.id)
			JOIN merchant AS m
			ON (t.id_merchant = m.id)
				JOIN merchant_category AS mc
				ON (m.id_merchant_category = mc.id);



SELECT *
FROM total_transactions

-- Total Sum of Transactions by Cardholder
SELECT name, ROUND(sum(amount)) AS "total_sum_by_name"
FROM total_transactions
GROUP BY name
ORDER BY "total_sum_by_name" DESC;

-- Isolate Data where transaction are small less than $2.00 order by cc_id
SELECT cc_id, ROUND(COUNT(amount)) AS "small_transactions"
FROM total_transactions 
WHERE total_transactions.amount <= 2
GROUP by cc_id
ORDER BY "small_transactions" DESC;










