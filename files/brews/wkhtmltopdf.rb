require 'formula'

class Wkhtmltopdf < Formula
  url 'http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.9.9.tar.bz2'
  homepage 'http://code.google.com/p/wkhtmltopdf/'
  sha1 '41f598c0103326e7c13101391447b0284b4ba3cb'
  version '0.9.9-boxen1'

  depends_on 'boxen/brews/qt'

  patch do
    url 'https://gist.githubusercontent.com/nemski/ac4af3cf291fdb09ffc9/raw/596b8c9b62e79ba50e4be5568171d7e916d5bb00/file_encoding_option'
    sha256 '60b3087647384e3a9d0fc17bd89f92732877254d7d7c441ae0c4b999383b2290'
  end

  def install
    # fix that missing TEMP= include
    inreplace 'wkhtmltopdf.pro' do |s|
      s.gsub! 'TEMP = $$[QT_INSTALL_LIBS] libQtGui.prl', ''
      s.gsub! 'include($$join(TEMP, "/"))', ''
    end

    # Always creates a useless .app doh,
    # AFAIK this is fixed in 0.10.0beta
    wkhtml_bin = 'wkhtmltopdf.app/Contents/MacOS/wkhtmltopdf'
    wkhtml_man = "#{name}.1"

    system "qmake"
    system "make"
    system "#{wkhtml_bin} --manpage > #{wkhtml_man}"

    # install binary and man file
    bin.install wkhtml_bin
    man1.install wkhtml_man
  end
end
