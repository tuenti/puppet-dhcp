# == Define: dhcp::shared_network
#
define dhcp::shared_network {

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat{"${dhcp_dir}/dhcpd.${name}.shared_networks": }
  concat::fragment { "dhcp_shared_network_${name}_header":
    target  => "${dhcp_dir}/dhcpd.${name}.shared_networks",
    content => template('dhcp/dhcpd.shared_network.header.erb'),
    order   => '01',
  }
  concat::fragment { "dhcp_shared_network_${name}_tail":
    target  => "${dhcp_dir}/dhcpd.${name}.shared_networks",
    content => '}',
    order   => '99',
  }
}

