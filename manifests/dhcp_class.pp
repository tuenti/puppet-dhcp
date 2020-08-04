# == Define: dhcp::dhcp_class
#
define dhcp::dhcp_class (
  Variant[Array[String[1]], String[1]] $parameters,
) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_class_${name}":
    target  => "${dhcp_dir}/dhcpd.classes",
    content => template('dhcp/dhcpd.class.erb'),
    order   => '40',
  }
}
