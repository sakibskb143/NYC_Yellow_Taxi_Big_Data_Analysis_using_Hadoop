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

valid_data = FILTER taxi_data BY fare_amount >= 0;

grouped_payment = GROUP valid_data BY payment_type;

average_fare = FOREACH grouped_payment GENERATE
    group AS payment_type,
    AVG(valid_data.fare_amount) AS average_fare;

DUMP average_fare;

STORE average_fare
INTO '/NYC-Yellow-Taxi-Analysis/output/pig/P2_AverageFare'
USING PigStorage(',');