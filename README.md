# WIDEBOT Infrastructure Provisioning Project

## Overview

This project demonstrates how to provision infrastructure for a web application with MongoDB, SQL Server, and Redis using Terraform, Docker, and Kubernetes for WIDEBOT. The setup is designed for a local environment on CentOS 7, allowing you to run and manage your application stack on your local machine.



### Description of Files and Folders

- **Dockerfile:** Contains instructions to build the Docker image for the web application.
- **terraform/main.tf:** Main Terraform configuration file for infrastructure resources.
- **terraform/variables.tf:** Defines variables for the Terraform configuration.
- **terraform/outputs.tf:** Specifies the output values for Terraform.
- **terraform/providers.tf:** Defines the providers for Terraform.
- **terraform/kubernetes/deployment.tf:** Kubernetes deployment resources.
- **terraform/kubernetes/service.tf:** Kubernetes service resources.
- **terraform/kubernetes/ingress.tf:** Kubernetes Ingress resources.
- **scripts/install_docker.sh:** Script to install Docker.
- **scripts/install_k8s.sh:** Script to install Kubernetes.
- **README.md:** Project documentation.

## Local Environment Justification

This project is designed for a local environment to simplify development and testing. Running the infrastructure locally ensures quick iteration and troubleshooting.

### Cloud Environment Considerations

To adapt this project for a cloud environment like AWS:
- Modify `providers.tf` to include AWS provider configurations.
- Use AWS-specific resources such as EC2 instances for VMs, RDS for SQL Server and MongoDB, and ElastiCache for Redis.
- Implement AWS load balancer configurations.
- Use Route 53 for DNS and Certificate Manager for SSL certificates.
- Set up VPC, security groups, and IAM roles for security and access management.

### Requirement Fulfillment

#### a. Infrastructure Provisioning

- **Configuration and Provisioning:**
  - `main.tf` provisions virtual machines or containers.
  - `deployment.tf` deploys the web application, MongoDB, SQL Server, and Redis as Docker containers in Kubernetes.

  ```hcl
  # main.tf
  resource "kubernetes_deployment" "app" {
    metadata {
      name = "myapp"
    }
    spec {
      replicas = 2
      selector {
        match_labels = {
          app = "myapp"
        }
      }
    }
  }
  ```

- **Scalability and Fault Tolerance:**
  - Kubernetes deployments and services are configured to be scalable and fault-tolerant.

  ```hcl
  # deployment.tf
  resource "kubernetes_deployment" "mongo" {
    metadata {
      name = "mongo"
    }
    spec {
      replicas = 3
      selector {
        match_labels = {
          app = "mongo"
        }
      }
    }
  }
  ```

#### b. Domain Name and SSL Certificate

- **Domain Name Configuration:**
  - Domain name registration is assumed to be external.
  - `ingress.tf` associates the domain with the application.

  ```hcl
  # ingress.tf
  resource "kubernetes_ingress" "example" {
    metadata {
      name = "example-ingress"
    }
    spec {
      rule {
        host = "example.com"
        http {
          path {
            path = "/"
            backend {
              service_name = "example-service"
              service_port = 80
            }
          }
        }
      }
    }
  }
  ```

- **SSL Certificate:**
  - Ingress resources handle SSL termination.

#### c. Load Balancer

- **Traffic Distribution:**
  - `service.tf` sets up Kubernetes services with type `LoadBalancer`.

  ```hcl
  # service.tf
  resource "kubernetes_service" "app" {
    metadata {
      name = "app-service"
    }
    spec {
      selector = {
        app = "myapp"
      }
      type = "LoadBalancer"
    }
  }
  ```

- **Health Checks and SSL Termination:**
  - Ingress configuration in `ingress.tf` handles health checks and SSL termination.

#### d. Databases

- **Provisioning:**
  - `deployment.tf` provisions MongoDB, SQL Server, and Redis.

  ```hcl
  # deployment.tf
  resource "kubernetes_deployment" "sqlserver" {
    metadata {
      name = "sqlserver"
    }
    spec {
      replicas = 2
      selector {
        match_labels = {
          app = "sqlserver"
        }
      }
    }
  }
  ```

- **Security and Configuration:**
  - Configurations include setting up authentication and access controls.

#### e. Caching

- **Redis Caching Layer:**
  - `deployment.tf` sets up Redis.
  - Application configuration to use Redis for caching is assumed to be part of the web application code.

  ```hcl
  # deployment.tf
  resource "kubernetes_deployment" "redis" {
    metadata {
      name = "redis"
    }
    spec {
      replicas = 2
      selector {
        match_labels = {
          app = "redis"
        }
      }
    }
  }
  ```

#### f. Security and Access Management

- **Security Measures:**
  - Basic security is implemented via Kubernetes services and Ingress.
  - Network security groups and firewall rules are assumed to be part of the cloud provider configuration.

- **Access Controls:**
  - Proper access credentials should be managed via Kubernetes Secrets.

## Project Diagram

```plaintext
                                 +--------------------+
                                 |     Load Balancer  |
                                 |   (Kubernetes Ingress)|
                                 +----------+---------+
                                            |
                                            |
                       +--------------------+--------------------+
                       |                                         |
          +------------+-------------+                +----------+-----------+
          |         Web Application  |                |     SQL Server       |
          |          (Kubernetes)    |                |     (Kubernetes)     |
          +------------+-------------+                +----------+-----------+
                       |
                       |
          +------------+-------------+
          |         MongoDB          |
          |         (Kubernetes)     |
          +------------+-------------+
                       |
                       |
          +------------+-------------+
          |           Redis          |
          |         (Kubernetes)     |
          +--------------------------+
```

This diagram illustrates the project architecture with a Load Balancer distributing traffic to the Web Application, which interacts with MongoDB, SQL Server, and Redis for data storage and caching.

## Setup Instructions

### Prerequisites

- CentOS 7
- Terraform
- Docker
- Kubernetes

### Steps to Reproduce

1. **Install Docker**

   Use the provided script to install Docker on CentOS 7:

   bash
   ./terraform/scripts/install_docker.sh
   

2. **Install Kubernetes**

   Use the provided script to install Kubernetes on CentOS 7:

   bash
   ./terraform/scripts/install_k8s.sh
   

3. **Apply Terraform Configuration**

   Navigate to the `terraform` directory and run:

   bash
   terraform init
   terraform apply
   

   Follow the prompts to apply the configuration.


## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
# WIDEBOT_Assignment
