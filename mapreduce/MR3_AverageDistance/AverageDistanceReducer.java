import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class AverageDistanceReducer
        extends Reducer<Text, Text, Text, Text> {

    @Override
    public void reduce(
            Text key,
            Iterable<Text> values,
            Context context)
            throws IOException, InterruptedException {

        double totalDistance = 0.0;
        long totalTrips = 0;

        for (Text value : values) {

            String[] parts =
                    value.toString().split(",");

            if (parts.length != 2) {
                continue;
            }

            try {

                double distance =
                        Double.parseDouble(parts[0]);

                long count =
                        Long.parseLong(parts[1]);

                totalDistance += distance;
                totalTrips += count;

            } catch (NumberFormatException e) {
                // Ignore invalid values
            }
        }

        if (totalTrips > 0) {

            double average =
                    totalDistance / totalTrips;

            context.write(
                    new Text(
                            "Average Trip Distance"
                    ),
                    new Text(
                            String.format(
                                    "%.4f miles",
                                    average
                            )
                    )
            );
        }
    }
}