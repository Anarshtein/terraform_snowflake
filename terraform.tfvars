# These variables are stored here for easy of use
# They can be adjusted whenever needed and you are only needed to change them here if needed


# The right-hand side of the following variables are needed to be replaced with
# your own information for each variable
# For security isuues they are replaced as "your_..."
username = "your_username"
role= "your_role"
pass= "your_password"
ware_name = "your_warehouse_name"
db_name = "your_database_name"
schema_name = "your_schema_name"
tab_name = "your_table_name"
my_role = "your_role_name"


# In case of new variable addition:
    # 1. Move to the "variable.tf" file and follow steps there(if haven't been done yet)
    # 2. Add the name you assigned to the new variable
    # 3. Give the value you want to use for the new variable on the right hand side of = sign in 4th step
    # 4. new_var = "your_value"