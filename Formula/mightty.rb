class Mightty < Formula
  desc "MighTTY host-side CLI and agent-event daemon"
  homepage "https://mightty.app"
  version "1.1.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-amd64.tar.gz"
      sha256 "fdbf733634b0d8be7b34fafd18fedad40d6e86a9462018fb43a0734db0b6a51b"
    end
    if Hardware::CPU.arm?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-arm64.tar.gz"
      sha256 "a651c8d317a98045b7222fb6e9f7eb509ce6844a7072d6574e114d766fda9e44"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-linux-amd64.tar.gz"
      sha256 "07f06818822ae820791503887cf005888a6766cdd501b0dd3f21de889f531b1b"
    end
  end

  def install
    bin.install Dir["mightty-*"].first => "mightty"
  end

  service do
    run [opt_bin/"mightty", "serve"]
    keep_alive true
    log_path var/"log/mightty.log"
    error_log_path var/"log/mightty.log"
    working_dir var
  end

  test do
    assert_match "mightty", shell_output("#{bin}/mightty version")
  end
end
