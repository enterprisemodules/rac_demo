# Contains all development specific stuff on vagrant boxes
class profile::base::vagrant()
{

    $required_packages = {
      'mlocate' => { ensure => 'present' },
      'unzip'   => { ensure => 'present' },
    }

    ensure_resources('package', $required_packages)

    exec { 'create swap file':
      command => '/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=16384',
      creates => '/var/swap.1',
    }

    -> exec { 'attach swap file':
      command => '/sbin/mkswap /var/swap.1 && /sbin/swapon /var/swap.1',
      unless  => '/sbin/swapon -s | grep /var/swap.1',
    }

    #add swap file entry to fstab
    -> exec {'add swapfile entry to fstab':
      command => '/bin/echo >>/etc/fstab /var/swap.1 swap swap defaults 0 0',
      user    => root,
      unless  => "/bin/grep '^/var/swap.1' /etc/fstab 2>/dev/null",
    }

    # Set NOZEROCONF RAC requirement
    -> file_line { 'nozeroconf':
      path   => '/etc/sysconfig/network',
      line   => 'NOZEROCONF=yes',
      match  => 'NOZEROCONF',
    }

}
