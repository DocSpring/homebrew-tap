class Docspring < Formula
  desc "DocSpring's command-line interface: fill PDF and Word templates, generate PDFs and manage templates from your terminal, scripts and CI"
  homepage "https://docspring.com/docs/cli/"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.1.0/docspring-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d6a0d43964d723090190076c5bfab670e9cd51b47fe9fd74b43d67892d3a8783"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.1.0/docspring-cli-x86_64-apple-darwin.tar.xz"
      sha256 "925ef6b7546147b117279a724504c22a2cedee5f44f72fe11212796ec3dc7e69"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.1.0/docspring-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ab1fb9d1aafd9c1cc1ccb0b2c5e1757d681ddef94270a250f5adeeed18c69133"
    end
    if Hardware::CPU.intel?
      url "https://github.com/DocSpring/docspring-cli/releases/download/v1.1.0/docspring-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "366ab43ea1dc65beebb926bb689205349767eef85f96ef79741687ad3ffe8dc7"
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
