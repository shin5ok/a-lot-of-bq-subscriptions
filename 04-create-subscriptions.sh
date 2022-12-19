for n in {1..100};
do

    t=$(printf "%05d" $n)
    echo $t
    gcloud pubsub subscriptions create newsubscription-table$t --topic=topic-table$t --use-topic-schema --bigquery-table=$PROJECT.dataset1.table$t --drop-unknown-fields
done
