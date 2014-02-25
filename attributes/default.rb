# encoding: UTF-8
#
# Cookbook Name:: openstack-metering
# Recipe:: default
#
# Copyright 2013, AT&T Services, Inc.
# Copyright 2013, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# The name of the Chef role that knows about the message queue server
# that Nova uses
default['openstack']['metering']['rabbit_server_chef_role'] = 'os-ops-messaging'

default['openstack']['metering']['conf_dir'] = '/etc/ceilometer'
default['openstack']['metering']['conf'] = ::File.join(node['openstack']['metering']['conf_dir'], 'ceilometer.conf')
default['openstack']['metering']['periodic_interval'] = 600
default['openstack']['metering']['syslog']['use'] = false
default['openstack']['metering']['verbose'] = 'true'
default['openstack']['metering']['debug'] = 'false'

default['openstack']['metering']['api']['auth']['cache_dir'] = '/var/cache/ceilometer/api'

default['openstack']['metering']['user'] = 'ceilometer'
default['openstack']['metering']['group'] = 'ceilometer'

default['openstack']['metering']['region'] = node['openstack']['region']
default['openstack']['metering']['service_user'] = 'ceilometer'
default['openstack']['metering']['service_tenant_name'] = 'service'

case platform
when 'suse' # :pragma-foodcritic: ~FC024 - won't fix this
  default['openstack']['metering']['platform'] = {
    'common_packages' => ['openstack-ceilometer'],
    'agent_central_packages' => ['openstack-ceilometer-agent-central'],
    'agent_central_service' => 'openstack-ceilometer-agent-central',
    'agent_compute_packages' => ['openstack-ceilometer-agent-compute'],
    'agent_compute_service' => 'openstack-ceilometer-agent-compute',
    'api_packages' => ['openstack-ceilometer-api'],
    'api_service' => 'openstack-ceilometer-api',
    'client_packages' => ['python-ceilometerclient'],
    'collector_packages' => ['openstack-ceilometer-collector'],
    'collector_service' => 'openstack-ceilometer-collector'
  }
when 'fedora', 'redhat', 'centos'
  default['openstack']['metering']['platform'] = {
    'common_packages' => ['openstack-ceilometer-common'],
    'agent_central_packages' => ['openstack-ceilometer-central'],
    'agent_central_service' => 'openstack-ceilometer-central',
    'agent_compute_packages' => ['openstack-ceilometer-compute'],
    'agent_compute_service' => 'openstack-ceilometer-compute',
    'api_packages' => ['openstack-ceilometer-api'],
    'api_service' => 'openstack-ceilometer-api',
    'client_packages' => ['python-ceilometerclient'],
    'collector_packages' => ['openstack-ceilometer-collector'],
    'collector_service' => 'openstack-ceilometer-collector'
  }

when 'ubuntu'
  default['openstack']['metering']['platform'] = {
    'common_packages' => ['ceilometer-common'],
    'agent_central_packages' => ['ceilometer-agent-central'],
    'agent_central_service' => 'ceilometer-agent-central',
    'agent_compute_packages' => ['ceilometer-agent-compute'],
    'agent_compute_service' => 'ceilometer-agent-compute',
    'api_packages' => ['ceilometer-api'],
    'api_service' => 'ceilometer-api',
    'client_packages' => ['python-ceilometerclient'],
    'collector_packages' => ['ceilometer-collector', 'python-mysqldb'],
    'collector_service' => 'ceilometer-collector'
  }
end
