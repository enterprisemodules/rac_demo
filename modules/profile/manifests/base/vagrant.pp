# Contains all development specific stuff on vagrant boxes
class profile::base::vagrant () {
  $required_packages = {
    'mlocate' => { ensure => 'present' },
    'unzip'   => { ensure => 'present' },
  }

  ensure_resources('package', $required_packages)

  swap_file::files { '16GB Swap':
    ensure       => present,
    swapfile     => '/var/swap.16gb',
    swapfilesize => '16GB',
  }

  # Set NOZEROCONF RAC requirement
  -> file_line { 'nozeroconf':
    path  => '/etc/sysconfig/network',
    line  => 'NOZEROCONF=yes',
    match => 'NOZEROCONF',
  }
}
