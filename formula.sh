#!/bin/bash
wget https://github.com/Appliscale/perun/archive/$1.tar.gz
sha=$(echo $1.tar.gz | sha256sum | awk '{print $1}')
rm $1.tar.gz
cat <<EOT > perundev.rb
class Perun < Formula
  desc "Swiss army knife for AWS CloudFormation templates"
  homepage "https://github.com/Appliscale/perun"
  url "https://github.com/Appliscale/perun/archive/$1.tar.gz"
  sha256 "$sha"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"

    dir = buildpath/"src/github.com/Appliscale/perun"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      system "make", "all"
    end

    bin.install "bin/perun"
  end

  test do
    system "#{bin}/perun", "--help"
  end
end
EOT
