import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class TotalTripsMapper
        extends Mapper<LongWritable, Text, Text, IntWritable> {

    private static final IntWritable ONE =
            new IntWritable(1);

    private static final Text TOTAL_TRIPS =
            new Text("Total Trips");

    @Override
    public void map(
            LongWritable key,
            Text value,
            Context context)
            throws IOException, InterruptedException {

        String line = value.toString().trim();

        // Ignore CSV header
        if (line.startsWith("VendorID")) {
            return;
        }

        // Ignore empty lines
        if (line.isEmpty()) {
            return;
        }

        context.write(TOTAL_TRIPS, ONE);
    }
}