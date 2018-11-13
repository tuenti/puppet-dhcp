# == Define: dhcp::host
#
define dhcp::host (
  Stdlib::Compat::Ip_address $ip,
  String $mac,
  String $ddns_hostname   = $name,
  Hash $options           = {},
  String $comment         ='',
  Boolean $ignored        = false,
  Optional[String] $group = undef,
) {

  $host = $name

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  if $shared_network {
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
