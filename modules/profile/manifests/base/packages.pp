class profile::base::packages()
{
  $required_package = [
    'iptables-services'
  ]

  package{ $required_package:
    ensure => 'installed',
  }

}
