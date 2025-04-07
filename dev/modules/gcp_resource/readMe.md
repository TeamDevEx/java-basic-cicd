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

gcloud projects add-iam-policy-binding off-net-dev \
 --member="serviceAccount:grafana-reload@off-net-dev.iam.gserviceaccount.com" \
 --role="roles/artifactregistry.writer"

# Kubectl

    kubectl get services
    kubectl expose deployment java-rest-app --type=LoadBalancer --name=my-service --port=80 --target-port=8080
    remove kubectl delete service my-service

# Docker

docker build -t northamerica-northeast1-docker.pkg.dev/off-net-dev/lendly-demo/spring-boot-rest-app:latest .  
docker push northamerica-northeast1-docker.pkg.dev/off-net-dev/lendly-demo/spring-boot-rest-app:latest

docker run -p 8080:8080 61d94589a90c

- deployment and load balancer can be build together

# the proble with this implementation is that the image is not recognized , comment strategy didnt work
