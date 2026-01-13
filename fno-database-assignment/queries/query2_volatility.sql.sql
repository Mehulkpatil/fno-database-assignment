WITH daily_prices AS (
    SELECT 
        trade_timestamp::DATE as trade_date,
        symbol,
        AVG(close_price) as avg_close
    FROM trades t
    JOIN instruments i ON t.instrument_id = i.instrument_id
    WHERE symbol LIKE 'NIFTY%'
        AND option_type IN ('CE', 'PE')
    GROUP BY trade_timestamp::DATE, symbol
)
SELECT 
    trade_date,
    symbol,
    avg_close,
    STDDEV(avg_close) OVER (
        PARTITION BY symbol 
        ORDER BY trade_date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) as rolling_7d_volatility
FROM daily_prices
ORDER BY trade_date DESC;