class mysql::repo
{
  include apt

  case $mysql::type{
    'oracle' : { # use standard packages
    }

    'percona': {
      apt::key {
        'CD2EFD2A':
      }

      # Puppetlabs/apt module
      apt::source { 'percona':
        ensure      => present,
        include_src => true,
        location    => 'http://repo.percona.com/apt',
        release     => $::lsbdistcodename,
        repos       => 'main',
        notify      => Exec['mysql::repo::apt-get update'],
        require     => Apt::Key['CD2EFD2A'],
      }
    }

    'mariadb': {
      apt::key {
        '1BB943DB':
      }

      # Puppetlabs/apt module
      # Sorry, ubuntu only
      apt::source { 'mariadb5.5':
        ensure      => present,
        include_src => true,
        location    => 'http://mirrors.coreix.net/mariadb/repo/5.5/ubuntu',
        release     => $::lsbdistcodename,
        repos       => 'main',
        notify      => Exec['mysql::repo::apt-get update'],
        require     => Apt::Key['1BB943DB'],
      }
    }
  }

  exec { 'mysql::repo::apt-get update':
    command     => 'apt-get update',
    path        => '/usr/bin',
    refreshonly => true,
  }

}
