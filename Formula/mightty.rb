class Mightty < Formula
  desc "MighTTY host-side CLI and agent-event daemon"
  homepage "https://mightty.app"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-amd64.tar.gz"
      sha256 "bcc0718ad8031bd60e7730a7b481560fa81df1b9034e9b60f1bd967be72a0eef"
    end
    if Hardware::CPU.arm?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-arm64.tar.gz"
      sha256 "18b529d3ad91a3c546a5be5c51f99ebaa584ad5aaa114b4e3e2bf3acb43b0a7f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-linux-amd64.tar.gz"
      sha256 "1de0b8b0fbfbd8cefecb9e2ef8911eb6079dd44c134d82ad53d5846d605ceaeb"
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
