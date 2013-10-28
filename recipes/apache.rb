#
# Cookbook Name:: tilestache
# Recipe:: apache
#
# Copyright 2013, Mapzen
#
# All rights reserved - Do Not Redistribute
#

case node[:tilestache][:apache_proxy]
when true
  include_recipe 'apache2'
  include_recipe 'apache2::mod_proxy'
  include_recipe 'apache2::mod_expires'
  include_recipe 'apache2::mod_proxy_http'
  include_recipe 'apache2::mod_proxy_connect'

  web_app 'tilestache-proxy' do
    template 'tilestache-proxy.conf.erb'
    proxy_port        node [:tilestache][:gunicorn][:port]
    server_name       node [:tilestache][:apache][:server_name]
    max               node [:tilestache][:apache][:max]
    ttl               node [:tilestache][:apache][:ttl]
    retrytimeout      node [:tilestache][:apache][:retrytimeout]
    connectiontimeout node [:tilestache][:apache][:connectiontimeout]
    timeout           node [:tilestache][:apache][:timeout]
    base_uri          node [:tilestache][:apache][:base_uri]
    canvas_map        node [:tilestache][:apache][:canvas_map]
    max_age           node [:tilestache][:apache][:max_age]
  end

  apache_site 'tilestache-proxy' do
    action :enable
  end
end

