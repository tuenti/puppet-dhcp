# == Define: dhcp::shared_network
#
define dhcp::shared_network (
  $dhcpd_conf_filename = 'dhcpd.conf',
){

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  $conf_file = "${dhcp_dir}/shared-networks/dhcpd.${name}"
  concat{$conf_file: }
  concat::fragment { "dhcp_shared_network_${name}_header":
    target  => $conf_file,
    content => "shared-network ${name} {\n",
    order   => '01',
  }
  concat::fragment { "dhcp_shared_network_${name}_hosts":
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => "include \"${conf_file}\";\n",
    order   => '99',
  }
  concat::fragment { "dhcp_shared_network_${name}_tail":
    target  => $conf_file,
    content => "}\n",
    order   => '99',
  }
}

