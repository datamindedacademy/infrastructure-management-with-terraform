module "prod-env" {
  source        = "../module/"
  environment   = "prod"
  notebook_name = "my-notebook"
  my_ip         = "0.0.0.0"
}