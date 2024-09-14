# @summary Manage packages
#
# @api private
class ulogd::install {
  if $ulogd::manage_package {
    stdlib::ensure_packages($ulogd::packages)
  }
}
