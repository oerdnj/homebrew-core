class GitCal < Formula
  desc "GitHub-like contributions calendar but on the command-line"
  homepage "https://github.com/k4rthik/git-cal"
  url "https://github.com/k4rthik/git-cal/archive/v0.9.1.tar.gz"
  sha256 "783fa73197b349a51d90670480a750b063c97e5779a5231fe046315af0a946cd"
  head "https://github.com/k4rthik/git-cal.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d409cf68f427e71e33abba6f0393860230882cb86a6cf58f8771135516d3afe2" => :catalina
    sha256 "b6b4128e6c8dfc678bf4301a506795533a3c1a20a449d342e57b78cd3274db5d" => :mojave
    sha256 "286c10cc47b2b26de4511fac0518d6edef3e05c676a45c14b32d8342891ecf2f" => :high_sierra
    sha256 "82847887556bd0334e65c1c7a3a063c2d62e5f71e81e89c53aa8e0df1cc41e31" => :sierra
    sha256 "8f928d65dc3414900ace5751d9e93bc712f03ffcabfefeb0d659e18db3998622" => :el_capitan
    sha256 "d61d27644f236dd221d2ea15aea7ee088afaf08c305217084b63fb85cb0d7dba" => :yosemite
    sha256 "2f09af33dd202d56be91b6bb7ead320cbc322332e411a7b712879a9198364e64" => :mavericks
  end

  def install
    system "perl", "Makefile.PL", "PREFIX=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "git", "init"
    (testpath/"Hello").write "Hello World!"
    system "git", "add", "Hello"
    system "git", "commit", "-a", "-m", "Initial Commit"
    system bin/"git-cal"
  end
end