# Get available zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}