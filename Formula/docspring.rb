class Docspring < Formula
  desc "DocSpring's command-line interface: fill PDF and Word templates, generate PDFs and manage templates from your terminal, scripts and CI"
  homepage "https://docspring.com/docs/cli/"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.1/docspring-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bfbb18a14b5c15a344dc9f79b7c635521e6418b08d80204283b2d214cc350a0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.1/docspring-cli-x86_64-apple-darwin.tar.xz"
      sha256 "97acc0a25f3562925e4c338311133c5c8f07eb8122ffb3f90489ea770ce2add9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.1/docspring-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a42390805b9a51d73a214dff62f5e648ad0c2b6e59a5bfb1ae0ad3e62d0f6159"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.1/docspring-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e146c00b496f91289d71d7347090ea8b87cc0c42625763e31379abd401dd71b7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "docspring"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "docspring"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "docspring"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "docspring"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
