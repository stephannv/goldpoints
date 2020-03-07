SELECT
	user_id,
	country_code,
	sum(points * records.group) AS points,
	sum(amount_cents * records.group) AS amount_cents,
	amount_currency
FROM
	records
GROUP BY
	user_id, country_code, amount_currency
HAVING
	sum(points * records.group) > 0
