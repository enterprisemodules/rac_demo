# Docs
class role::oradb::rac_node()
{
  contain profile::base
  contain profile::dns
  contain ora_profile::database

  Class['profile::base']
  -> Class['profile::dns']
  -> Class['ora_profile::database']
}
