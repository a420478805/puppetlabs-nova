class nova::vncproxy(
  $enabled        = false,
  $host           = '0.0.0.0',
  $port           = '6080',
  $ensure_package = 'present'
) {

  include nova::params

  # TODO make this work on Fedora

  # See http://nova.openstack.org/runnova/vncconsole.html for more details.

  nova_config {
    'novncproxy_host': value => $host;
    'novncproxy_port': value => $port;
  }

  nova::config{'vnc':
        config=>{
  		'novncproxy_host' => $host,
		'novncproxy_port' => $port,
		'novncproxy_base_url'=> 'false',
                'vncserver_listen'=> 'false',
   		'vnc_enabled'    =>  'false',
		'vncserver_proxyclient_address' => 'false',
 	},
	order => '02',
  }

  package { 'python-numpy':
    name   => $::nova::params::numpy_package_name,
    ensure => present,
  }

  nova::generic_service { 'vncproxy':
    enabled        => $enabled,
    package_name   => $::nova::params::vncproxy_package_name,
    service_name   => $::nova::params::vncproxy_service_name,
    ensure_package => $ensure_package,
    require        => Package['python-numpy']
  }

}
