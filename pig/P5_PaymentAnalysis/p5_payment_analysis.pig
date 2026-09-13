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

valid_data = FILTER taxi_data
BY total_amount >= 0
AND trip_distance >= 0;

grouped_payment =
    GROUP valid_data BY payment_type;

payment_analysis =
    FOREACH grouped_payment GENERATE
        group AS payment_type,
        COUNT(valid_data) AS total_trips,
        SUM(valid_data.total_amount) AS total_revenue,
        AVG(valid_data.trip_distance) AS average_distance;

ordered_result =
    ORDER payment_analysis BY total_revenue DESC;

DUMP ordered_result;

STORE ordered_result
INTO '/NYC-Yellow-Taxi-Analysis/output/pig/P5_PaymentAnalysis'
USING PigStorage(',');