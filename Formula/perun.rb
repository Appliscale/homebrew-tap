class Perun < Formula
  desc "Swiss army knife for AWS CloudFormation templates"
  homepage "https://github.com/Appliscale/perun"
  url "https://github.com/Appliscale/perun/archive/1.3.1.tar.gz"
  sha256 "f56b5993161293dd3f72f597a24700d0a2841909b8650231cbfd1edbb3217da1"

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
