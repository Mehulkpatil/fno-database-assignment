# Futures & Options Database Design

## Overview
Relational database for storing and analyzing F&O data from Indian exchanges.

## Database Schema
- Normalized to 3NF
- Supports NSE, BSE, MCX exchanges
- Optimized for time-series queries

## Setup Instructions
1. Run `database/schema.sql`
2. Load data using `database/load_data.sql`
3. Create indexes: `database/indexes.sql`

## Sample Queries
See `queries/` folder for analytical queries.
