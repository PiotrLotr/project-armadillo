
resource "aws_service_discovery_private_dns_namespace" "aws-service-discovery" {
  name = "local"
  vpc  = aws_vpc.main.id
}

###################################################################
resource "aws_service_discovery_service" "app-service" {
  name = "app-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.aws-service-discovery.id

    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  # health_check_custom_config {
  #   failure_threshold = 1
  # }
}

################################################################
resource "aws_service_discovery_service" "db-service" {
  name = "db-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.aws-service-discovery.id

    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  # health_check_custom_config {
  #   failure_threshold = 1
  # }
}
