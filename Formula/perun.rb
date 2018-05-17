class Perun < Formula
  desc "Swiss army knife for AWS CloudFormation templates"
  homepage "https://github.com/Appliscale/perun"
  url "https://github.com/Appliscale/perun/archive/1.1.0.tar.gz"
  sha256 "cdf194a27337326d25530c2fed2b48bf6c7a6b41be980f2f2a6d614f7f9b2142"

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
