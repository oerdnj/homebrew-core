class Tnote < Formula
  desc "Small note-taking program for the terminal"
  homepage "https://tnote.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/tnote/tnote/tnote-0.2.1/tnote-0.2.1.tar.gz"
  sha256 "451e0e352cb279725c5e12ad1c1377be63c7113f3fe568fb6213ede478ba6a87"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e2a07cb0af64d0111a52360a6b04c883343898ad6df6a458a2616f75ab562126" => :catalina
    sha256 "54026c946cb475ed1e08617e78307d8f71afaf000fa8d9a92e75a21717694580" => :mojave
    sha256 "cba19ccd15645c46e579818a294817efe9a80421ae8768572406bf24b26912a2" => :high_sierra
    sha256 "cba19ccd15645c46e579818a294817efe9a80421ae8768572406bf24b26912a2" => :sierra
  end

  depends_on "python@2" # does not support Python 3

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
    man1.install Dir[libexec/"share/man/man1/*"]
  end

  test do
    ENV["EDITOR"] = "/bin/cat"
    system bin/"tnote", "--nocol", "-a", "test"
  end
end