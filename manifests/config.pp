#
# Can be used to specify configuration
# sections in nova1.conf
#
# It will assume that the config
#
#
define nova::config(
  $config    = {},
  $file_name = regsubst($name, ':', '_', 'G'),
  $content   = template("nova/${name}.erb"),
  $order     = undef
) {

  concat::fragment { "nova-${name}":
    target  => '/etc/nova/nova1.conf',
    content => $content,
    order   => $order,
  }
}
