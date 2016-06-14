Chef-Repo Exercise on AWS
===============
This is an exercise to demo Chef scripting for my interview. The list of requirements before starting:

* Development environment with Ruby, AWS CLI tools, Chef SDK
* AWS account with properly configured IAM settings (AWS Marketplace_full_access role), publicly accessible VPC, and EC2 policies.
* Chef Server AMI license obtained via AWS Marketplace

In summary, the steps were:

* Create an EC2 Chef Server instance and connect to it via web UI and SSH (needed to validate node name of server)
* Configure server with an initial organization called david
* Download Starter kit from Chef Server which contains AWS connectivity parameters for workstation.
* Configure workstation (my laptop) with Chef tools. Configure knife.rb file with updated DNS name. Validated connectivity to server via knife client list
* Configured initial recipe to do apt-get update daily, install apache, and loaded HTML template
* HTML template is an erb file (embedded Ruby syntax) located [here](cookbooks/learn_chef_apache2/templates/default/index.html.erb)
* See recipe [here](cookbooks/learn_chef_apache2/recipes/default.rb)
* Date of exercise: June 13, 2016

The server that was deployed with this exercise is live at: http://ec2-54-175-32-111.compute-1.amazonaws.com

Tail end of results of `knife bootstrap` command:
![First Image](images/chef_scr_grab.png)
Screen grab from Chef Server showing that node has been bootstrapped; this node is an Ubuntu EC2 instance separate from Chef Server instance:
![Second Image](images/node_scr_grab.png)
Screen grab of Chef Server showing that the recipe has been configured and uploaded to the Chef server:
![Third Image](images/policy_scr_grab.png)
Screen grab showing successful recipe deployment:
![Fourth Image](images/report_scr_grab.png)
