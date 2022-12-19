bq mk dataset1

for n in {1..100};
do
    t=$(printf "%05d" $n)
    echo $t
    bq mk --use_avro_logical_types --schema bq-schema.json -t dataset1.table$t
done
