# Demo Puppet implementation

This repo contains a demonstration of a simple database installation. It contains no patches and hardly any setup inside of the database (e.g. tablespaces, users, synomyms). It's purpose is to help you guide through an initial installation of an Oracle node with Puppet.
The name of the node indicates which version of Oracle will be installed in it i.e. db112 has version 11.2.

## Starting the nodes masterless

All nodes are available to test with Puppet masterless. To do so, add `ml-` for the name when using vagrant:

```
$ vagrant up <ml-db112|ml-db121|ml-db122>
```

## Staring the nodes with PE

You can also test with a Puppet Enterprise server. To do so, add `pe-` for the name when using vagrant:

```
$ vagrant up pe-master
$ vagrant up <pe-db112|pe-db121|pe-db122>
```

## ordering

You must always use the specified order:

1. master
2. <db112|db121|db122>

## Required software

The software must be placed in `modules/software/files`. It must contain the next files:

### Puppet Enterprise
- puppet-enterprise-2016.5.1-el-7-x86_64.tar.gz (Extracted tar)


### Oracle Database version 11.2.0.4
- p13390677_112040_Linux-x86-64_1of7.zip
- p13390677_112040_Linux-x86-64_2of7.zip
### Oracle Database version 12.1.0.2
- linuxamd64_12102_database_1of2.zip
- linuxamd64_12102_database_2of2.zip
### Oracle Database version 12.2.0.1
- linuxx64_12201_database.zip

You can download this file from
[here](http://support.oracle.com)
or
[here](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle12c-linux-12201-3608234.html)
