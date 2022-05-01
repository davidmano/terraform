locals {
    az = {
        load_balancer = {
            name = "lb-${var.service}-${var.environment}-${var.region}-${var.instance}"
            name_unique = "dfffffffffffffffff"
        }
        storage_account = {
            name = "sa${var.service}${var.environment}${var.region}${var.instance}"
                  dashes      = false
                    min_length  = 3
                max_length  = 24
            scope       = "global"
                regex       = "^[a-z0-9]+$"
        }
        recovery_services_vault = {
            name = "rsv-${var.service}-${var.environment}-${var.region}-${var.instance}"
        }
    }
}