# == Define: dhcp::pool
#
define dhcp::pool (
  Stdlib::Compat::Ipv4 $network,
  Stdlib::Compat::Ipv4 $mask,
  $gateway                                  = '',
  $range                                    = '',
  $failover                                 = '',
  $options                                  = '',
  $parameters                               = '',
  $pool_parameters                          = '',
  Optional[Array[String]] $nameservers      = undef,
  Optional[Array[String]] $nameservers_ipv6 = undef,
  Optional[String] $pxeserver               = undef,
  Optional[Integer] $mtu                    = undef,
  String $domain_name                       = '',
  $ignore_unknown                           = undef,
  $shared_network                           = undef,
) {
  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  if $shared_network {
    $content_target = "${dhcp_dir}/shared-networks/dhcpd.${shared_network}"
  } else {
    $content_target = "${dhcp_dir}/dhcpd.pools"
  }

  concat::fragment { "dhcp_pool_${name}":
    target  => $content_target,
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
