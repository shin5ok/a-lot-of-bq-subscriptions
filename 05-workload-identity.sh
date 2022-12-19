kubectl create serviceaccount --namespace default pubsub-app
gcloud iam service-accounts create pubsub-app
gcloud projects add-iam-policy-binding $PROJECT     --member "serviceAccount:pubsub-app@$PROJECT.iam.gserviceaccount.com"     --role "roles/pubsub.publisher"
gcloud iam service-accounts add-iam-policy-binding     --role roles/iam.workloadIdentityUser     --member "serviceAccount:$PROJECT.svc.id.goog[default/pubsub-app]"     pubsub-app@$PROJECT.iam.gserviceaccount.com
kubectl annotate serviceaccount \
    --namespace default pubsub-app \
    iam.gke.io/gcp-service-account=pubsub-app@$PROJECT.iam.gserviceaccount.com
