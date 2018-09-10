class Perun < Formula
  desc "Swiss army knife for AWS CloudFormation templates"
  homepage "https://github.com/Appliscale/perun"
  url "https://github.com/Appliscale/perun/archive/1.3.0.tar.gz"
  sha256 "1d891cf4febc9d29fa1bc26674468fcd6b62c02b44c05aa559f1b20f7685996c"

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
