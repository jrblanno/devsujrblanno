# My Django Application on Azure Kubernetes Service (AKS)

This project deploys a Django application to an AKS cluster using Terraform and Helm.

## Prerequisites

- Azure CLI
- Terraform
- Helm
- kubectl

## Deployment Steps

1. Clone this repository:


# build infra
terraform init
terraform apply

## Add the nginx to the cluster 
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx

# deploz through helm
helm install my-django-app ./my-django-chartkubectl get service my-django-app


# GitHub Actions CI/CD Pipeline

This pipeline is designed to automate the build, test, and deployment of a Django application to an Azure Kubernetes Service (AKS) cluster using Terraform and Helm.

## Workflow

The pipeline is triggered on any push or pull request to the `main` branch, or can be manually triggered from the Actions tab in GitHub.

The pipeline consists of the following steps:

1. **Checkout**: This step checks out the repository code to the GitHub Actions runner.

2. **Build and Test**: This step navigates to the `demo-app` directory, sets environment variables, installs Python dependencies, runs Django migrations, and starts the Django server. It then generates a random user and inserts it into the database, retrieves all users, and checks if the inserted user exists. If the user is found, the test is successful; otherwise, the test fails.

3. **Docker Build and Push**: This step logs into Docker Hub using secrets, builds a Docker image of the Django application, and pushes it to Docker Hub.

4. **Terraform Init, Plan, and Apply**: These steps navigate to the `infra` directory, initialize Terraform, plan the Terraform changes, and apply the Terraform configuration. This creates the AKS cluster.

5. **AKS Get Credentials**: This step retrieves the credentials for the AKS cluster.

6. **Helm Install**: This step navigates to the `infra` directory and installs the Helm chart for the Django application on the AKS cluster.

## Secrets

The pipeline uses the following secrets:

- `ENVIRONMENT`: The environment for the Django application.
- `DJANGO_SECRET_KEY`: The secret key for the Django application.
- `DOCKER_USERNAME`: The Docker Hub username.
- `DOCKER_PASSWORD`: The Docker Hub password.
- `AKS_RESOURCE_GROUP`: The Azure resource group for the AKS cluster.
- `AKS_CLUSTER_NAME`: The name of the AKS cluster.

These secrets should be set in the GitHub repository settings.

## Requirements

- A Docker Hub account to host the Docker image.
- An Azure account to host the AKS cluster.
- Terraform installed on the GitHub Actions runner.
- Helm installed on the GitHub Actions runner.