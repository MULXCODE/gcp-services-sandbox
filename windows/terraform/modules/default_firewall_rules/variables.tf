variable "network_name" {
  description = "The network in which to add these firewalls to."
  default     = "default"
}

variable "source_range" {
  description = "The source range to allow the usage of these firewall rules.  Defaults to all 0.0.0.0/0."
  default     = "0.0.0.0/0"
}
