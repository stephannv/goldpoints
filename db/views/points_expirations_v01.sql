SELECT
	user_id,
	country_code,
	expires_on,
	sum(amount_cents) AS amount_cents,
	amount_currency,
	sum(points) as points
FROM
	records r
WHERE
	occurred_at > COALESCE(
    (SELECT
      MAX(occurred_at)
    FROM
      records r2
    WHERE
      r2.group = -1
      AND r2.country_code = r.country_code
      AND r2.user_id = r.user_id
    ),
    '1900-01-01'::DATE
  )
GROUP BY
	user_id,
  country_code,
  expires_on,
  amount_currency
ORDER BY
	user_id,
  expires_on,
  sum(points)
