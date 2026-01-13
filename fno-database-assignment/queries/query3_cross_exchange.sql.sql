SELECT 
    'MCX GOLD' as instrument_type,
    AVG(close_price) as avg_price,
    COUNT(*) as trade_count
FROM trades t
JOIN instruments i ON t.instrument_id = i.instrument_id
WHERE i.instrument_type = 'FUT'
    AND i.symbol LIKE '%GOLD%'
UNION ALL
SELECT 
    'NSE INDEX FUT',
    AVG(close_price),
    COUNT(*)
FROM trades t
JOIN instruments i ON t.instrument_id = i.instrument_id
WHERE i.instrument_type = 'FUT'
    AND i.symbol LIKE 'NIFTY%';
