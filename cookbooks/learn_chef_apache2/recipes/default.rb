#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Initial sample recipe to initiate a basic web server with an HTML page

# Configure server to run apt-get update daily
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# Install and start Apache web server
package 'apache2'

service 'apache2' do
  supports :status => true
  action [:enable, :start]
end

# Place HTML file to display
template '/var/www/html/index.html' do
  source 'index.html.erb'
end
