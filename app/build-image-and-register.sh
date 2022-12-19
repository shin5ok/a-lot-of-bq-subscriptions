TAG=$1
if test -z $TAG;
then
    TAG=$(date '+%Y%m%d%H%M')
fi
echo TAG=$TAG is building
gcloud builds submit -t gcr.io/$PROJECT/pubsub-app:$TAG

echo TAG=$TAG has been built
