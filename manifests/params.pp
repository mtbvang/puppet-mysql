class mysql::params
{
  $packages = $mysql::type ? {
    'oracle'  => [ 'mysql-server-5.1' ],
    'percona' => [ 'percona-server-server-5.6' ],
    'mariadb' => [ 'mariadb-server-5.5' ],
  }

  $packages_extra = $mysql::type ? {
    'oracle'  => [ 'maatkit' ],
    'percona' => [ 'maatkit', 'xtrabackup' ],
    'mariadb' => [ 'maatkit'],
  }

  $service = $mysql::type ? {
    'oracle'  => [ 'mysql' ],
    'percona' => [ 'mysql' ],
    'mariadb' => [ 'mysql' ],
  }
}
