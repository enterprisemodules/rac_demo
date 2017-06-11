# Docs
class role::oradb::rac_master()
{
  contain ::profile::base
  contain ::profile::oradb::rac_master

  Class['::profile::base']
  -> Class['::profile::oradb::rac_master']
}
