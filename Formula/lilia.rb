class Lilia < Formula
  desc "Local-first multimodel embedded and daemon database (CLI, Daemon & MCP)"
  homepage "https://liliadb.org"
  version "0.1.0-alpha.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-darwin-arm64.tar.gz"
      sha256 "4c7a4e6f75eafc782918a3ce038e53af430f781c8e19690d3d77edcb9a9b8e38"
    else
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-darwin-x64.tar.gz"
      sha256 "75c48e346d9f88a4e29d2aa3948d5c8028eb0287f368ed25383bb6c57d91eec8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-linux-arm64-gnu.tar.gz"
      sha256 "bb01c8fb1727bbf915e9b6a54ae638e90b8235697cfc3be7bcaafb5c8763787b"
    else
      url "https://github.com/shaynlink/liliadb/releases/download/v#{version}/lilia-linux-x64-gnu.tar.gz"
      sha256 "73bb073f8c1d3d03059e91036ff0085fa9e4cbbb595198359891306b632d2307"
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
