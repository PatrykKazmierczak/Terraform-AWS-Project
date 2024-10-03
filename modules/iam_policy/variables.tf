variable "name" {
    type = string
    description = "Nazwa polityki"
  
}

variable "statements" {
  type = map(object({
    effect   = string
    actions  = set(string)
    resource = set(string)
  }))
}
