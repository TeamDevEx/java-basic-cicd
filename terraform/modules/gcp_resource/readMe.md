- terraform front template is fine -- add GCP SA and GIT token

# CLuster First | Autopilot

# Deployment

# Load balancer

- Iam role add
- Kubernetes Engine Cluster Admin
- Compute Instance Admin (v1)
- Compute Viewer

# Kubernetes Engine Developer

gcloud projects add-iam-policy-binding off-net-dev \
 --member=serviceAccount:grafana-reload@off-net-dev.iam.gserviceaccount.com \
 --role=roles/container.developer

gcloud projects add-iam-policy-binding off-net-dev \
 --member=serviceAccount:grafana-reload@off-net-dev.iam.gserviceaccount.com \
 --role=roles/container.admin

gcloud projects add-iam-policy-binding off-net-dev \
 --member=serviceAccount:grafana-reload@off-net-dev.iam.gserviceaccount.com \
 --role=roles/compute.networkAdmin

# Kubectl

    kubectl get services
    kubectl expose deployment java-rest-app --type=LoadBalancer --name=my-service --port=80 --target-port=8080
    remove kubectl delete service my-service
