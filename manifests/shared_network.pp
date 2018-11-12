# == Define: dhcp::shared_network
#
define dhcp::shared_network (
  $dhcpd_conf_filename = 'dhcpd.conf',
){

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  $conf_file = "${dhcp_dir}/dhcpd.${name}.shared_network"
  concat{$conf_file: }
  concat::fragment { "dhcp_shared_network_${name}_header":
    target  => $conf_file,
    content => template('dhcp/dhcpd.shared_network.header.erb'),
    order   => '01',
  }
  concat::fragment { "dhcp_shared_network_${name}_hosts":
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => "include \"${conf_file}\";",
    order   => '999',
  }
  concat::fragment { "dhcp_shared_network_${name}_tail":
    target  => $conf_file,
    content => '}',
    order   => '99',
  }
}

