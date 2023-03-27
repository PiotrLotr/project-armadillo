# common
fargate_cpu="1024"
fargate_memory="2048"
aws_region="eu-central-1"
az_count="3"


# app_spec
app_container_name="app"
app_image="251865263936.dkr.ecr.eu-central-1.amazonaws.com/armadillo-app:latest"
app_port=80
app_count=2

# db_spec
db_container_name="mongo-db"
db_image="251865263936.dkr.ecr.eu-central-1.amazonaws.com/armadillo-db:latest"
db_port=27017
db_count=1

# healthcheck
health_check_path="/healthcheck"
