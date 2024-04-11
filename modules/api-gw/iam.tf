variable "retention_in_days" {
    type        = number
    description = "The number of days to retain log events in the log group."
    default     = 30
}