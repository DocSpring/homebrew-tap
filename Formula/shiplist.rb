class Shiplist < Formula
  desc "Checks every file in a repository is in one list, and what ships in images"
  homepage "https://github.com/DocSpring/shiplist"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.0/shiplist-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "b31fed31d35538faf880e83e7b69d02164a92032802afde10b38423d4a1ebbbe"
    end
    on_intel do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.0/shiplist-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "6e839a49132258742d70862c538cc3842b3025bae24d623715cee3752af86180"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.0/shiplist-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6761627be92e840e544d31bc5f9be171762a9eee94adf6d0d1aab1bb740908c7"
    end
    on_intel do
      url "https://github.com/DocSpring/shiplist/releases/download/v0.1.0/shiplist-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "800f0f149aefe68df1302d50a268f5f13fc9af6ba530d48fb49da8df76bbf5ac"
    end
  end

  def install
    bin.install "shiplist"
  end

  test do
    assert_match "shiplist #{version}", shell_output("#{bin}/shiplist --version")
  end
end
