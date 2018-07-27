# forge in this file will not be used by r10k, so it is defined in r10k.yaml
forge 'http://forge.enterprisemodules.com'


mod 'puppetlabs-stdlib',                    '4.25.1'
mod 'puppetlabs-concat',                    '4.2.1'
mod 'stm-debconf',                          '2.0.0'
mod 'saz-limits',                           '3.0.2'
mod 'petems-swap_file',                     '4.0.0'
mod 'puppet-archive',                       '3.0.0'
mod 'saz-timezone',                         '4.1.1'
mod 'ipcrm-echo',                           '0.1.5'
mod 'herculesteam-augeasproviders_core',    '2.1.4'
mod 'herculesteam-augeasproviders_sysctl',  '2.2.0'
mod 'puppetlabs-firewall',                  '1.12.0'
mod 'crayfishx-firewalld'

# Added for RAC:
mod 'fiddyspence-sleep',              '1.2.0'

#
# The Enterprise Modules Oracle specific Modules
#
# mod 'enterprisemodules-ora_config',   '2.6.4'
mod 'enterprisemodules-ora_config',   :local => true
# mod 'enterprisemodules-easy_type',    '2.4.4'
mod 'enterprisemodules-easy_type',    :local => true
# mod 'enterprisemodules-ora_install',  '3.0.14'
mod 'enterprisemodules-ora_install',  :local => true
# mod 'enterprisemodules-ora_profile',  '0.3.0'
mod 'enterprisemodules-ora_profile',  :local => true
mod 'enterprisemodules-ora_cis',      '1.0.6'

# Added for RAC:
# mod 'enterprisemodules-ora_rac',      '2.0.1'
# mod 'enterprisemodules-ora_rac',      :local => true
mod 'enterprisemodules-partition',    :local => true

#
# Modules that are part of the control repo. R10K doesn't need to touch these
#
mod 'role',       :local => true
mod 'profile',    :local => true
mod 'em_license', :local => true
mod 'software',   :local => true
