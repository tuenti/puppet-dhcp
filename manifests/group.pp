# == Define: dhcp::group
#
define dhcp::group (
  String           $dhcpd_conf_filename = 'dhcpd.conf',
  Optional[String] $shared_network      = undef,
  Hash[String]     $options             = {},
  Array[String]    $parameters          = [],
){

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  if $shared_network {
    $content_target = "${dhcp_dir}/shared-networks/dhcpd.${shared_network}"
  } else {
    $content_target = "${dhcp_dir}/${dhcpd_conf_filename}"
  }

  $conf_file = "${dhcp_dir}/groups/dhcpd.${name}"
  concat{$conf_file: }
  concat::fragment { "dhcp_group_${name}_header":
    target  => $conf_file,
    content => template('dhcp/dhcpd.group.erb'),
    order   => '01',
  }
  concat::fragment { "dhcp_group_${name}_include":
    target  => $content_target,
    content => "include \"${conf_file}\";\n",
    order   => '99',
  }
  concat::fragment { "dhcp_group_${name}_tail":
    target  => $conf_file,
    content => "}\n",
    order   => '99',
  }
}

