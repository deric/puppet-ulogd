# @summary Manage user space logging daemon
#
# @param manage_package Whether package should be managed
# @param package_ensure
# @param packages
# @param manage_service
# @param service_name
# @param service_ensure
# @param config_path
# @param config Configuration as a Hash
#
# @example
#   include ulogd
class ulogd (
  Boolean              $manage_package,
  String               $package_ensure,
  Array[String,1]      $packages,
  Boolean              $manage_service,
  String               $service_name,
  String               $service_ensure,
  Stdlib::Absolutepath $config_path,
  Ulogd::Config        $config = {}
) {
  include ulogd::install

  file { $config_path:
    ensure  => file,
    content => epp("${module_name}/config.epp", { 'config' => $config }),
    require => Class['Ulogd::Install'],
  }

  if $manage_service {
    service { $service_name:
      ensure    => $service_ensure,
      enable    => true,
      require   => Class['Ulogd::Install'],
      subscribe => File[$config_path],
    }
  }
}
