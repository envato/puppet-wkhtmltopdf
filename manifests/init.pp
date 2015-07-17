# Public: Install wkhtmltopdf via homebrew
#
# Examples
#
#   include wkhtmltopdf
class wkhtmltopdf($version = '0.9.9') {
  include homebrew
  include qt

  homebrew::formula { "wkhtmltopdf-${version}":
    before => Package['boxen/brews/wkhtmltopdf'],
  }

  package { 'boxen/brews/wkhtmltopdf':
    ensure  => "${version}-boxen1",
    require => Class['qt'],
  }
}
