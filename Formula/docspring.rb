class Docspring < Formula
  desc "DocSpring's command-line interface: fill PDF and Word templates, generate PDFs and manage templates from your terminal, scripts and CI"
  homepage "https://docspring.com/docs/cli/"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.0/docspring-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f68247af4c2e373966c4181dfe3b5f0035ad3ad326d6ca797ae1fcfb50d73890"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.0/docspring-cli-x86_64-apple-darwin.tar.xz"
      sha256 "507d4c8822195bd40aca4114e57ed782700666db6e87a1fed9bb349dc95300ae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.0/docspring-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "82f1252a6309f32498256ebe6d8b6ecc7966c69f29c4f5cfbb40ef6e47450b7b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.0.0/docspring-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d9640bfa932e37ba74fcdd6ff59c3174c90c4b0f758d8ee8a40847c3acdc5105"
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
