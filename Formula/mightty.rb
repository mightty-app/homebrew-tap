class Mightty < Formula
  desc "MighTTY host-side CLI and agent-event daemon"
  homepage "https://mightty.app"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-amd64.tar.gz"
      sha256 "51e78e84d31705fa0d82acf7ffb3390facffc11a034105417032e265f1163cdb"
    end
    if Hardware::CPU.arm?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-darwin-arm64.tar.gz"
      sha256 "182fc9132090748ec162fda6be98ddb1d22f28091fdf49e8e2931e526d0cb3c0"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://dl.mightty.app/mightty/v#{version}/mightty-linux-amd64.tar.gz"
      sha256 "5264eb802e40f528c62c11a3c397e79c11074a1fdc582aa236c70a862e33cb7a"
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
