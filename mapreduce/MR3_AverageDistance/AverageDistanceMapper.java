import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class AverageDistanceMapper
        extends Mapper<LongWritable, Text, Text, Text> {

    private static final Text TOTAL =
            new Text("TOTAL");

    @Override
    public void map(
            LongWritable key,
            Text value,
            Context context)
            throws IOException, InterruptedException {

        String line = value.toString();

        if (line.startsWith("VendorID")) {
            return;
        }

        String[] fields =
                line.split(",", -1);

        if (fields.length < 5) {
            return;
        }

        try {

            double distance =
                    Double.parseDouble(
                            fields[4].trim()
                    );

            if (distance >= 0) {

                context.write(
                        TOTAL,
                        new Text(
                                distance + ",1"
                        )
                );
            }

        } catch (NumberFormatException e) {
            // Ignore invalid values
        }
    }
}