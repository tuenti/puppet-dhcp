# == Define: dhcp::pool6
#
define dhcp::pool6 (
  Stdlib::IP::Address::V6 $network,
  Integer $prefix,
  String $range                             = '',
  String $range_temp                        = '',
  String $failover                          = '',
  String $options                           = '',
  String $parameters                        = '',
  Optional[Array[String]] $nameservers      = undef,
  Optional[Array[String]] $nameservers_ipv6 = undef,
  Optional[String] $pxeserver               = undef,
  Optional[Integer] $mtu                    = undef,
  String $domain_name                       = '',
  $ignore_unknown                           = undef,
) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool6.erb'),
  }
}
