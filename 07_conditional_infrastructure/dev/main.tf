module "dev-env" {
  source        = "../module"
  environment   = "dev"
  my_ip         = "0.0.0.0"
  notebook_name = "my-notebook"
}