class Shiplist < Formula
  desc "Checks every file in a repository is in one list, and what ships in images"
  homepage "https://github.com/DocSpring/shiplist"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.1/shiplist-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "f7d5485291461aecfb5dab52c0601896c12754595cd7caa22f3186e0b403348e"
    end
    on_intel do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.1/shiplist-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "4094b25fc4d413edec4b79d1197e7d768d3861744d3adc159b20daabb9cc2682"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.1/shiplist-v0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "924f7ee8cd83f38693f80a6005b1459bde2d5303c5a1ac9439ff4d323e1a87cf"
    end
    on_intel do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.1/shiplist-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "27559814f7f8155cc78310bc468fb1e67a92bf327ec15a3c0cf2539f0a12ffd2"
    end
  end

  def install
    bin.install "shiplist"
  end

  test do
    assert_match "shiplist #{version}", shell_output("#{bin}/shiplist --version")
  end
end
