class Perun < Formula
  require 'digest'

  desc "Swiss army knife for AWS CloudFormation templates"
  homepage "https://github.com/Appliscale/perun"
  spruce_type = perun-darwin-amd64
  url = `curl -s https://api.github.com/repos/Appliscale/perun/releases/latest | jq -r ".assets[] | select(.name | test(\"${spruce_type}\")) | .browser_download_url"`
  sha256 = Digest::SHA256.file url

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
