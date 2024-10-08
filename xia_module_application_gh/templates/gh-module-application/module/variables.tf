variable "module_name" {
  type = string
  description = "Module Name"
}

variable "config_file" {
  type = string
  description = "Module config file"
  default = ""
}

variable "config_dir" {
  type = string
  description = "Module config dictionary"
  default = ""
}

variable "landscape" {
  type = any
  description = "Landscape Configuration"
}

variable "applications" {
  type = map(any)
  description = "Application Configuration"
}

variable "environment_dict" {
  type = map(any)
  description = "Environment Configuration"
}

variable "app_env_config" {
  type = map(any)
  description = "Application Environment Configuration"
}

variable "module_app_to_activate" {
  type = map(list(any))
  description = "Application to be activated for all modules"
}

