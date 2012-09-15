class nova::create_ip(
  $fixed_range,
  $num_networks     = 1,
  $floating_range   = false,
  $create_networks  = true,
) {

   if $create_networks 
   {
    nova::manage::network { 'nova-vm-net':
      network       => $fixed_range,
      num_networks  => $num_networks,
    }
    if $floating_range {
      nova::manage::floating { 'nova-vm-floating':
        network       => $floating_range,
      }
    }
  }


}
