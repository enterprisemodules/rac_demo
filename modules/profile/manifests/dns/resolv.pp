# Setup resolv.conf so the ne=ameserver on the master node is used
# Plus some other network things
class profile::dns::resolv(
  String $nameserver,
)
{
  file { '/etc/NetworkManager/conf.d/no-dns.conf':
    ensure => present,
    source => 'puppet:///modules/profile/no-dns.conf',
    notify => Service['NetworkManager'],
  }

  -> service { 'NetworkManager':
    ensure => running,
  }

  -> package { 'bind-utils':
    ensure => present,
  }

  -> file { '/etc/resolv.conf':
    ensure  => present,
    content => template('profile/resolv.conf.erb'),
  }
}
