class profile::base::packages()
{
  case $facts['os']['release']['major'] {
    7: {
      $required_package = [
        'iptables-services'
      ]
      package{ $required_package:
        ensure => 'installed',
      }
    }
    default: {}
  }
}
