# Docs
class role::oradb::rac_node()
{
  contain profile::base
  contain ora_profile::database

  Class['profile::base']
  -> Class['ora_profile::database']
}
