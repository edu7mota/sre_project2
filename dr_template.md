# Infrastructure

## AWS Zones
us-east-2
us-west-2

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| EKS | Cluster managemnet nodes for the application | Managed by AWS | 3 nodes | Instance deployed into 1 region. Needs to be deployed to another region for DR |
| EC2 Worker Node | Cluster worker node running grafana | t3.medium | 1 node | Instance deployed into 1 region. Needs to be deployed to another region for DR |
| Application Load Balancer | Load balancer that exposes an endpoint for the grafana app | N/A | 1 | Requires to be deployed to another region |
| EC2 instance | Server running the web app | t3.micro | 1 instance | Instance deployed into 1 region. Needs to be deployed to another region for DR | 
| Aurora MySQL | Database backend for web app | db.t2.small | 1 cluster | Instance deployed to 1 region needs a second region for HA |

### Descriptions
More detailed descriptions of each asset identified above.

* EKS - Manages the cluster and is AWS managed. Terraform created in order to deploy to second region
* EC2 Worker - Cluster worker node to host grafana, this is part of the cluster deployment
* Application Load Balancer - Load balancer for the grafana application
* EC2 wen instane - Main application server with exposure to the internet
* RDS Aurora MySQL - Database backend for the main application

## DR Plan
### Pre-Steps:
* Download terraform repo
* Have credentials to AWS account with proper permissions

## Steps:

* Run terraform to create cluster, ec2 instance, and rds in new region.
* Modify prometheus config to point to new ip of ec2 instance
* Install prometheus
* Create monitoring dashboards in grafana