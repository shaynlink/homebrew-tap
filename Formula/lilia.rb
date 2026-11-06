class Lilia < Formula
  desc "Local-first multimodel embedded and daemon database (CLI, Daemon & MCP)"
  homepage "https://liliadb.org"
  version "0.1.0-alpha.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-darwin-arm64.tar.gz"
      sha256 "d18167f74bff50967f2808be9b8221b70647f716422d6c331dad8786ccffd32c"
    else
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-darwin-x64.tar.gz"
      sha256 "a05563252e6e5d235779163b68cf5abeedea0757351a73d5ce49165a7ec2817c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-linux-arm64-gnu.tar.gz"
      sha256 "add00774fb73447363b8c004e6a06d9d8ff2be0ec387790444a9ad584046b496"
    else
      url "https://github.com/shaynlink/lilia/releases/download/v#{version}/lilia-linux-x64-gnu.tar.gz"
      sha256 "5c8ab60d49b0ea982842af9a7a72a5e3b0778a7c7123bdd3900ced0a2ac51077"
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
