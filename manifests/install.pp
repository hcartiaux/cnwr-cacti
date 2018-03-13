# == Class cacti::install
#
# This class is called from cacti for install.
#
class cacti::install inherits cacti{

  package { $::cacti::cacti_package:
    ensure => present,
  }

  if($::selinux_enforced){

    # Move http scripts under /var/www/html, add symlink to /usr/share/cacti and
    # restore context on the files
    exec {'mv /usr/share/cacti /var/www/html/ && ln -s /var/www/html/cacti /usr/share && restorecon -v -r /var/www/html/cacti':
      creates => '/var/www/html/cacti',
      require => Package[$::cacti_package];
    }
  }
}
