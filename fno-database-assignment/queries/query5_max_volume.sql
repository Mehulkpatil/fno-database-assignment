EXPLAIN ANALYZE
SELECT 
    trade_timestamp::DATE as trade_date,
    i.symbol,
    SUM(contracts_traded) as daily_volume,
    MAX(SUM(contracts_traded)) OVER () as max_volume
FROM trades t
JOIN instruments i ON t.instrument_id = i.instrument_id
WHERE t.trade_timestamp >= NOW() - INTERVAL '30 days'
GROUP BY trade_timestamp::DATE, i.symbol
ORDER BY daily_volume DESC
LIMIT 10;