class Lilia < Formula
  desc "Local-first multimodel embedded and daemon database (CLI, Daemon & MCP)"
  homepage "https://liliadb.org"
  version "0.1.0-alpha.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-darwin-arm64.tar.gz"
      sha256 "140be767dfbf819aed10b1a462f2e465300868c38c8ab01051a11eeadd81b6c2"
    else
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-darwin-x64.tar.gz"
      sha256 "ea3708186711845aac1c60d1c917465113cc6713906f1be7f5044213a536ffad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-linux-arm64-gnu.tar.gz"
      sha256 "b7f6079812a2c9f8e9217533400724c586aaad61e71b65f1cd814582b1aa6110"
    else
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-linux-x64-gnu.tar.gz"
      sha256 "b38924a311b6544488c631062ed8dd3f1f8fe3069c0d636ca6ddb43524bfebef"
    end
  end

  def install
    bin.install "lilia"
    bin.install "lilia-daemon"
    bin.install "lilia-mcp"
  end

  service do
    run [opt_bin/"lilia-daemon", "--database", var/"liliadb/database.lilia", "--http-port", "4444"]
    keep_alive true
    working_dir var/"liliadb"
    log_path var/"log/lilia-daemon.log"
    error_log_path var/"log/lilia-daemon.log"
  end

  test do
    assert_match "lilia", shell_output("#{bin}/lilia --help")
  end
end
