taxi_data = LOAD '/NYC-Yellow-Taxi-Analysis/input/taxi_noheader.csv'
USING PigStorage(',')
AS (
    VendorID:int,
    pickup_datetime:chararray,
    dropoff_datetime:chararray,
    passenger_count:int,
    trip_distance:double,
    pickup_longitude:double,
    pickup_latitude:double,
    RatecodeID:int,
    store_and_fwd_flag:chararray,
    dropoff_longitude:double,
    dropoff_latitude:double,
    payment_type:int,
    fare_amount:double,
    extra:double,
    mta_tax:double,
    tip_amount:double,
    tolls_amount:double,
    improvement_surcharge:double,
    total_amount:double
);

valid_data = FILTER taxi_data BY total_amount >= 0;

grouped_data = GROUP valid_data ALL;

total_revenue = FOREACH grouped_data GENERATE
    SUM(valid_data.total_amount) AS total_revenue;

DUMP total_revenue;

STORE total_revenue
INTO '/NYC-Yellow-Taxi-Analysis/output/pig/P1_TotalRevenue'
USING PigStorage(',');