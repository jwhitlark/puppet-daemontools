# manifests/define.pp

# ensure can be running or stopped
define daemontools::service(
    $ensure = 'running',
    $source
){
    case $operatingsystem {
        debian: { $service_directory = "/etc/service" }
        default: { $service_directory = "/service" }
    }

    case $ensure {
        'running': { $real_ensure = $source }
        'stopped': { $real_ensure = 'absent' }
        default: { fail("no such modus for daemontools::service") }
    }

    file{"${service_directory}/${name}":
        ensure => $real_ensure,
        require => Package['daemontools'],
    }
}
