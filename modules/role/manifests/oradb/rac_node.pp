# Docs
class role::oradb::rac_node()
{
  contain ::profile::base
  contain ::ora_rac::requirements
  contain ::ora_rac::db_server

  Class['::profile::base']
  -> Class['::ora_rac::requirements']
  -> Class['::ora_rac::db_server']
}
