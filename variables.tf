# These are the variable "declarations"

# In case of new variable addition:
    # 1. Copy the following configuration and un-comment it at the place where you will paste it
    # 2. This is the configuration:
        #  variable "your_variable_name" {
        #      description = "your_description"
        #      type = your_type
        # }   
    # 3. Change "your_variable_name" to the preferred variable name
    # 4. Add description if needed, otherwise you can delete it
    # 5. Mention the type of the variable
    # 6. Move to the "terraform.tfvars" file and follow the instructions there


variable "account"{
    description = "This is for Snowflake account"
    type = string
}
variable "username"{
    description = "This is for Snowflake username"
    type = string
}

variable "role"{
    description = "This is for Snowflake role"
    type = string
}
variable "pass" {
  description = "This is for Snowflake account password"
  type    = string
}

variable "ware_name"{
    description = "This is for Snowflake Warehouse name"
    type = string
}

variable "db_name" {
    description = "This is for Snowflake Database Name"
    type = string
}

variable "schema_name" {
    description = "This is for Snowflake Schema Name"
    type = string
}

variable "tab_name" {
    description = "This is for Snowflake Table Name"
    type = string
  
}
variable "my_role" {
    description = "This is for Snowflake Role to Assign User"
    type = string
  
}