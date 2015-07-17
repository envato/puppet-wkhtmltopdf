require 'formula'

class Wkhtmltopdf < Formula
  homepage 'http://code.google.com/p/wkhtmltopdf/'
  url 'https://launchpad.net/ubuntu/+archive/primary/+files/wkhtmltopdf_0.9.0.orig.tar.gz'
  sha256 '628363a79c82eb835e436cd62bce1b7323aed4e707affe57c3248e337a3ed18b'
  version '0.9.0'

  depends_on 'boxen/brews/qt'

  def install
    # fix that missing TEMP= include.
    inreplace 'wkhtmltopdf.pro' do |s|
      s.gsub! 'TEMP = $$[QT_INSTALL_LIBS] libQtGui.prl', ''
      s.gsub! 'include($$join(TEMP, "/"))', ''
    end

    if MacOS.version >= :mavericks && ENV.compiler == :clang
      spec = 'unsupported/macx-clang-libc++'
    else
      spec = 'macx-g++'
    end

    system 'qmake', '-spec', spec
    system 'make'
    `wkhtmltopdf.app/Contents/MacOS/wkhtmltopdf --manpage > wkhtmltopdf.1`

    bin.install "wkhtmltopdf.app/Contents/MacOS/wkhtmltopdf"
    man1.install "wkhtmltopdf.1"
  end
end