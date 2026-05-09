variable "rds" {
  type = object({
    rds_properties = list(object({
      name    = string
      db_name = string
      db_user = string
      db_pass = string
    }))
  })
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "aws_db_subnet_group_vpc_id" {
  type = string
}