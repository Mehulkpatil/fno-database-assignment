SELECT 
    expiry_date,
    strike_price,
    option_type,
    COUNT(*) as total_trades,
    SUM(contracts_traded) as total_contracts,
    AVG(close_price) as avg_price,
    SUM(open_interest) as total_oi
FROM trades
WHERE option_type IN ('CE', 'PE')
    AND expiry_date IS NOT NULL
    AND strike_price IS NOT NULL
GROUP BY expiry_date, strike_price, option_type
ORDER BY expiry_date, strike_price;