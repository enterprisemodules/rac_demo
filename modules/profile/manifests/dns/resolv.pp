# Setup resolv.conf so the ne=ameserver on the master node is used
# Plus some other network things
class profile::dns::resolv(
  String $nameserver,
)
{
  case $facts['os']['release']['major'] {
    '6': {
      # Prevent NetworkManager from changing /etc/resolv.conf
      file_line { '/etc/NetworkManager/NetworkManager.conf':
        path   => '/etc/NetworkManager/NetworkManager.conf',
        line   => 'dns=none',
        match  => '^dns=',
        notify => Service['NetworkManager'],
      }
      -> service { 'NetworkManager':
        ensure => running,
      }
    }
    default: {
      case $facts['os']['release']['minor'] {
        '0','1','2','3','4','5','6': {
          # Prevent dhclient from changing /etc/resolv.conf
          file { '/etc/dhcp/dhclient-enter-hooks':
            ensure => present,
            source => 'puppet:///modules/profile/dhclient-enter-hooks',
            mode   => '0755',
          }
          # Prevent NetworkManager from changing /etc/resolv.conf
          -> file { '/etc/NetworkManager/conf.d/no-dns.conf':
            ensure => present,
            source => 'puppet:///modules/profile/no-dns.conf',
            notify => Service['NetworkManager'],
          }
          -> service { 'NetworkManager':
            ensure => running,
          }
        }
        default: {
          # Prevent dhclient from changing /etc/resolv.conf
          file { '/etc/dhcp/dhclient-enter-hooks':
            ensure => present,
            source => 'puppet:///modules/profile/dhclient-enter-hooks',
            mode   => '0755',
          }
        }
      }
    }
  }

  package { 'bind-utils':
    ensure => present,
  }

  -> file { '/etc/resolv.conf':
    ensure  => present,
    content => template('profile/resolv.conf.erb'),
  }
}
