# Configure dns server on masternode
# and setup all nodes to use it
class profile::dns()
{
  $master_node = lookup('ora_profile::database::master_node')
  if ( $master_node == $facts['hostname'] ) {
    contain profile::dns::bind
  }
  contain profile::dns::resolv
}
