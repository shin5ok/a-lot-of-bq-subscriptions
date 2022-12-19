
for n in {1..100};
do

    t=$(printf "%05d" $n)
    echo $t
    gcloud pubsub topics create --schema=my-schema --message-encoding=json topic-table$t
done
