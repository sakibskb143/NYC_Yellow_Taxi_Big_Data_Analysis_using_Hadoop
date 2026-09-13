import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
public class PaymentTypeMapper
        extends Mapper<Object, Text, Text, IntWritable> {

    private static final IntWritable ONE =
            new IntWritable(1);

    @Override
    public void map(
            Object key,
            Text value,
            Context context)
            throws IOException, InterruptedException {

        String line = value.toString();

        if (line.startsWith("VendorID")) {
            return;
        }
        String[] fields =
                line.split(",", -1);

        if (fields.length < 12) {
            return;
        }

        String paymentType =
                fields[11].trim();

        if (!paymentType.isEmpty()) {

            context.write(
                    new Text(paymentType),
                    ONE
            );
        }
    }
}