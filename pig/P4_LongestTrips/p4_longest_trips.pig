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

valid_trips = FILTER taxi_data
BY trip_distance > 0 AND trip_distance < 100;

sorted_trips =
    ORDER valid_trips BY trip_distance DESC;

top_10 =
    LIMIT sorted_trips 10;

result = FOREACH top_10 GENERATE
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    fare_amount,
    total_amount;

DUMP result;

STORE result
INTO '/NYC-Yellow-Taxi-Analysis/output/pig/P4_LongestTrips'
USING PigStorage(',');