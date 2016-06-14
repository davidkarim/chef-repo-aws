# See https://docs.chef.io/aws_marketplace.html/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "davidkarim"
client_key               "#{current_dir}/davidkarim.pem"
validation_client_name   "david-validator"
validation_key           "#{current_dir}/david-validator.pem"
chef_server_url          "https://ec2-52-91-121-104.compute-1.amazonaws.com/organizations/david"
cookbook_path            ["#{current_dir}/../cookbooks"]
