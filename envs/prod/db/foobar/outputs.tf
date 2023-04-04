output "db_instance_this_address" {
  value = one(aws_db_instance.this[*].address)
}
