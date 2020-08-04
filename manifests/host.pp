# == Define: dhcp::host
#
define dhcp::host (
  Optional[Stdlib::IP::Address] $ip     = undef,
  Dhcp::Mac $mac,
  String $ddns_hostname                 = $name,
  Hash $options                         = {},
  String $comment                       = '',
  Boolean $ignored                      = false,
  Optional[Integer] $default_lease_time = undef,
  Optional[Integer] $max_lease_time     = undef,
  Array[String[1]] $on_commit           = [],
  Array[String[1]] $on_release          = [],
  Array[String[1]] $on_expiry           = [],
  Optional[String] $group               = undef,
) {

  $host = $name

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  if $group {
    $content_target = "${dhcp_dir}/groups/dhcpd.${group}"
  } else {
    $content_target = "${dhcp_dir}/dhcpd.hosts"
  }

  concat::fragment { "dhcp_host_${name}":
    target  => $content_target,
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
