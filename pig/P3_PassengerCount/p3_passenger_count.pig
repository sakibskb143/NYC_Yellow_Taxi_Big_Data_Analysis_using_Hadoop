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
BY passenger_count > 0;

grouped_passengers =
    GROUP valid_data BY passenger_count;

passenger_trips =
    FOREACH grouped_passengers GENERATE
        group AS passenger_count,
        COUNT(valid_data) AS total_trips;

ordered_result =
    ORDER passenger_trips BY passenger_count ASC;

DUMP ordered_result;

STORE ordered_result
INTO '/NYC-Yellow-Taxi-Analysis/output/pig/P3_PassengerCount'
USING PigStorage(',');