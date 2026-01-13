SELECT 
    i.symbol,
    i.instrument_type,
    SUM(t.change_in_oi) as total_oi_change,
    SUM(t.open_interest) as total_oi
FROM trades t
JOIN instruments i ON t.instrument_id = i.instrument_id
WHERE t.trade_timestamp >= NOW() - INTERVAL '7 days'
GROUP BY i.symbol, i.instrument_type
ORDER BY ABS(SUM(t.change_in_oi)) DESC
LIMIT 10;