SLEEP=0.01

for n in {1..100};
do
    t=$(printf "%05d" $n)
    echo $t

    TOPIC_ID=topic-table$t
    GOOGLE_CLOUD_PROJECT=$PROJECT_ID \
    TOPIC_ID=$TOPIC_ID \
    APP_ID=$TOPIC_ID \
    SLEEP=$SLEEP \
    UPTO=$UPTO \
    envsubst < ./app/pod.yaml > t.yaml
    kubectl apply -f t.yaml
    rm -f t.yaml

done
