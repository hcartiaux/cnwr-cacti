# == Class cacti::params
#
# This class is meant to be called from cacti.
# It sets variables according to platform.
#
class cacti::params {
  $database_user = 'cacti'
  $database_host = 'localhost'
  $database_type = 'mysql'
  $database_default = 'cacti'
  $database_port = '3306'
  $database_ssl = false
  $managed_services = []
  $database_root_pass = undef
  $database_pass = undef

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '7': {
          $cacti_package = 'cacti'
          $cacti_user    = 'cacti'
          $cacti_sql_file_path = '/usr/share/doc/cacti-1.1.10/cacti.sql'
        }
        '8': {
          $cacti_package = 'cacti'
          $cacti_user    = 'apache'
          $cacti_sql_file_path = '/usr/share/doc/cacti/cacti.sql'
        }
        default: {
          fail("${::operatingsystem} ${::operatingsystemmajrelease} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
