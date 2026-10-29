class Lilia < Formula
  desc "Local-first multimodel embedded and daemon database (CLI, Daemon & MCP)"
  homepage "https://liliadb.org"
  version "0.1.0-alpha.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-darwin-arm64.tar.gz"
      sha256 "0c1a74e5d6cf698bcbc62025ae92f6479bbb0f916ed5a30dd2d83532b606b3de"
    else
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-darwin-x64.tar.gz"
      sha256 "5e20c1ce82865a1600ef0ed4efb5d0c88ba4111c2822f10597811d04759387b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-linux-arm64-gnu.tar.gz"
      sha256 "1b3aec0e889e1dd6d01deeb7a8835dac3e6fa04bb0f4811b15138ac18e32d7e3"
    else
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-linux-x64-gnu.tar.gz"
      sha256 "8cf2407a86b3ee26c10597c27259164a5cca9d49854016df91eb469b23163e17"
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
