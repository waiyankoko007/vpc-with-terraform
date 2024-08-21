output "my_zone" {
  value = data.aws_availability_zones.available.names
}