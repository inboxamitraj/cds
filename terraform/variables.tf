variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "region" {
  type = string
}

variable "min_nodes" {
  type = number
}

variable "max_nodes" {
  type = number
}

variable "desired_nodes" {
  type = number
}

variable "instance_type" {
  type = string
}