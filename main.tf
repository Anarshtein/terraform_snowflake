terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake" // This specifies the source of the Snowflake provider plugin.
      version = ">=0.61" // This sets the minimum version of the Snowflake provider plugin required by this configuration.
    }
  }
}

provider "snowflake" {
  account = var.account // This sets the Snowflake account ID to be used for provisioning resources.
  user = var.username // This sets the Snowflake username for authentication.
  role     = var.role // This sets the Snowflake role to be assumed by the user.
  password = var.pass  // This sets the password for the Snowflake user.
}

resource "snowflake_warehouse" "terraf-warehouse" {
  name = var.ware_name // This sets the name of the Snowflake warehouse to be provisioned.
  warehouse_size = "X-SMALL"  // This sets the size of the Snowflake warehouse.
}

resource "snowflake_database" "mterraf_database" {
  name = var.db_name // This sets the name of the Snowflake database to be provisioned.
}

resource "snowflake_schema" "terraf_schema" {
  database = snowflake_database.mterraf_database.name // This specifies the database in which the schema will be created.
  name     = var.schema_name // This sets the name of the Snowflake schema to be provisioned.
}

resource "snowflake_table" "product_inventory" {
  database = snowflake_database.mterraf_database.name // This specifies the database in which the table will be created.
  schema   = snowflake_schema.terraf_schema.name // This specifies the schema in which the table will be created.
  name     = var.tab_name // This sets the name of the Snowflake table to be provisioned.
  column { // This block defines a column in the Snowflake table.
    name = "ProductID" // This sets the name of the column.
    type = "INTEGER" // This sets the data type of the column.
  }
  column { // This block defines another column in the Snowflake table.
    name = "ProductName" // This sets the name of the column.
    type = "VARCHAR(255)" // This sets the data type of the column with a maximum length of 255 characters.
  }
  column { // This block defines another column in the Snowflake table.
    name = "Quantity" // This sets the name of the column.
    type = "NUMBER(10, 2)" // This sets the data type of the column as a number with precision 10 and scale 2.
  }
  column { // This block defines another column in the Snowflake table.
    name = "LastUpdated" // This sets the name of the column.
    type = "TIMESTAMP_NTZ" // This sets the data type of the column as a timestamp in the current time zone.
  }
}

resource "snowflake_role" "role_for_user" {
  name    = var.my_role // This sets the name of the Snowflake role to be provisioned.
}

resource "snowflake_grant_privileges_to_role" "grant-1" {
  role_name  = snowflake_role.role_for_user.name // This specifies the role to which privileges will be granted.
  privileges = ["USAGE"] // This sets the privileges to be granted on the specified object.
  on_account_object { // This block specifies the object on which privileges will be granted.
    object_type = "WAREHOUSE" // This sets the type of the object to be a Snowflake warehouse.
    object_name = snowflake_warehouse.terraf-warehouse.name // This specifies the name of the warehouse on which privileges will be granted.
  }
}

resource "snowflake_grant_privileges_to_role" "grant-2" {
  privileges = ["USAGE"] // This sets the privileges to be granted on the specified object.
  role_name  = snowflake_role.role_for_user.name // This specifies the role to which privileges will be granted.
  on_account_object { // This block specifies the object on which privileges will be granted.
    object_type = "DATABASE" // This sets the type of the object to be a Snowflake database.
    object_name = snowflake_database.mterraf_database.name // This specifies the name of the database on which privileges will be granted.
  }
}

resource "snowflake_grant_privileges_to_role" "grant-3" {
  privileges = ["USAGE"] // This sets the privileges to be granted on the specified object.
  role_name  = snowflake_role.role_for_user.name // This specifies the role to which privileges will be granted.
  on_schema { // This block specifies the schema on which privileges will be granted.
    schema_name = "${snowflake_database.mterraf_database.name}.${snowflake_schema.terraf_schema.name}" // This constructs the full schema name by concatenating database and schema names.
  }
  depends_on = [ // This specifies the dependencies for this resource to ensure proper execution order.
    snowflake_role.role_for_user, // This resource depends on the creation of the specified role.
    snowflake_database.mterraf_database, // This resource depends on the creation of the specified database.
    snowflake_schema.terraf_schema, // This resource depends on the creation of the specified schema.
    snowflake_table.product_inventory // This resource depends on the creation of the specified table.
  ]
}
