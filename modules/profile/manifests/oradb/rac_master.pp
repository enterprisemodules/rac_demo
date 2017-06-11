#
# Class to create the first node in a RAC cluster.
#
class profile::oradb::rac_master(
  String[0,8]               $san1_name                = '',
  String[0,8]               $san2_name                = '',
  Enum['enabled', 'disabled']
                            $enable_oracle_archivelog = 'enabled',
  Integer                   $db_processes             = 1500,
  Integer                   $db_open_cursors          = 1500,
  Enum['FALSE','ONLY', 'TRUE']
                            $db_use_large_pages       = 'FALSE',
  Optional[Easy_type::Size] $db_sga_target            = undef,
  Optional[Easy_type::Size] $db_sga_max_size          = undef,
  Optional[Easy_type::Size] $db_pga_aggregate_target  = undef,
  Easy_type::Size           $asm_sga_max_size         = '1024M',
  Integer                   $asm_processes            = 300,
  Enum['FORCE', 'SIMILAR', 'EXACT']
                            $cursor_sharing           = 'EXACT'
)
{
  include ::ora_rac::params

  contain ::ora_rac::requirements
  contain ::ora_rac::disk_groups

  #
  # Define all parameters used in the init.ora.eb
  #
  $oracle_home               = $ora_rac::settings::oracle_home
  $oracle_base               = $ora_rac::settings::oracle_base
  $db_name                   = $ora_rac::params::db_name
  $domain_name               = $ora_rac::params::domain_name
  $password                  = $ora_rac::params::password
  $scan_name                 = $ora_rac::params::scan_name
  $scan_port                 = $ora_rac::params::scan_port
  $memory_target             = $ora_rac::params::memory_target
  $memory_max_target         = $ora_rac::params::memory_max_target
  $db_32k_cache_size         = (4 * $::processorcount)
  $data_file_destination     = $ora_rac::settings::data_file_destination
  $recovery_area_destination = $ora_rac::settings::recovery_area_destination

  case $::operatingsystemmajrelease {
    '5':       {$asm_package = Package[cvuqdisk]}
    '6','7':   {$asm_package = Package[oracleasmlib]}
    default: {fail('unsupported OS version.')}
  }

  class{'::ora_rac::db_master':
    db_name          => $db_name,
    domain_name      => $ora_rac::params::domain_name,
    init_ora_content => template('profile/oradb/init.ora.erb'),
    require          => [
      $asm_package,
      Class['::ora_rac::requirements'],
    ],
  }

  # #
  # # Settings for ASM that are different then default
  # #
  # ora_exec{"create pfile='init_org.ora' from spfile@+ASM1":
  #   refreshonly => true,
  #   subscribe   => Class['ora_rac::db_master'],
  # }
  #
  # ora_init_param{'SPFILE/processes@+ASM1':
  #   ensure  => present,
  #   value   => $asm_processes,
  #   require => Class['ora_rac::db_master'],
  # }
  #
  # ora_init_param{'SPFILE/sga_max_size@+ASM1':
  #   ensure  => present,
  #   value   => $asm_sga_max_size,
  #   require => Class['ora_rac::db_master'],
  # }
  #
  # ora_exec{'grant sysasm to sys@+ASM1':
  #   refreshonly => true,
  #   subscribe   => Class['ora_rac::db_master'],
  # }
  #
  # ora_tablespace{"USERS@${db_name}1":
  #   bigfile                  => 'no',
  #   size                     => '5M',
  #   autoextend               => 'on',
  #   next                     => '1M',
  #   max_size                 => '1024M',
  #   extent_management        => 'local',
  #   segment_space_management => 'auto',
  #   require                  => Class['ora_rac::db_master'],
  # }
  #
  # -> ora_exec{"alter database default tablespace users@${db_name}1":
  #   refreshonly => true,
  #   subscribe   => Class['ora_rac::db_master'],
  # }
  #
  # ora_init_param{"SPFILE/CURSOR_SHARING@${db_name}1":
  #     ensure  => present,
  #     value   => $cursor_sharing,
  #     require => Class['ora_rac::db_master'],
  # }
  #
  # exec{'distribute_ocr':
  #   command     => "ocrconfig -add ${ora_rac::settings::recovery_area_destination}; ocrconfig -add ${ora_rac::settings::data_file_destination}; ocrconfig -delete +${ora_rac::params::crs_disk_group_name}",
  #   path        => "${ora_rac::settings::grid_home}/bin:/bin",
  #   unless      => "ocrconfig -add ${ora_rac::settings::recovery_area_destination} | grep 'PROT-29: The Oracle Cluster Registry location is already configured'",
  #   refreshonly => true,
  #   subscribe   => Class['ora_rac::db_master'],
  # }
  #
  # -> ora_profile {"DEFAULT@${db_name}1":
  #   failed_login_attempts => 'UNLIMITED',
  #   password_life_time    => 'UNLIMITED',
  #   require               => Class['ora_rac::db_master'],
  # }
}
