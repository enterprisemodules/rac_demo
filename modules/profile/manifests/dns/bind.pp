# Installs a nameserver on master node where
# round robin scan address is resolved
class profile::dns::bind(
  String $domain,
  Array  $listen_on,
  Hash   $hash_data,
  Array  $forwarders,
)
{

    class { 'bind':
      config => {
        listen-on   => $listen_on,
        forwarders  => $forwarders,
        allow-query => [
          'localhost',
          'any',
        ],
      }
    }

    bind::acl { 'bind acl':
      ensure => present,
      acls   => [
        'any',
      ],
    }

    bind::zone { $domain:
      ensure       => present,
      zone_contact => "contact.${domain}",
      zone_ns      => ["ns.${domain}"],
      zone_serial  => '2012112901',
      zone_ttl     => '604800',
      zone_origin  => $domain,
    }

    bind::a { $domain:
      ensure    => present,
      zone      => $domain,
      ptr       => false,
      content   => template('profile/bind.erb'),
      hash_data => $hash_data,
    }
}
