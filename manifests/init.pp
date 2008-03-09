# modules/skeleton/manifests/init.pp - manage skeleton stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "skeleton": }

class skeleton {
    case $operatingsystem {
        gentoo: { include skeleton::gentoo }
        default: { include skeleton::base }
    }
}

class skeleton::base {
    package{'skeleton':
        ensure => installed,
    }

    service{skeleton:
        ensure => running,
        enable => true,
        #hasstatus => true, #fixme!
        require => Package[skeleton],
    }

}

class skeleton::gentoo inherits skeleton::base {
    Package[skeleton]{
        category => 'some-category',
    }

    #conf.d file if needed
#    file { "/etc/conf.d/skeleton":
#        owner => "root",
#        group => "0",
#        mode  => 644,
#        ensure => present,
#        source => [
#            "puppet://$server/dist/skeleton/conf.d/${fqdn}/skeleton",
#            "puppet://$server/dist/skeleton/conf.d/skeleton",
#            "puppet://$server/skeleton/conf.d/skeleton"
#        ]
#    }
}
