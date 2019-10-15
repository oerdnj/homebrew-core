class Scdoc < Formula
  desc "Small man page generator"
  homepage "https://git.sr.ht/~sircmpwn/scdoc/"
  url "https://git.sr.ht/~sircmpwn/scdoc/archive/1.10.0.tar.gz"
  sha256 "3482e08b994cc4a528caf3d20dd70efda2d2ec86b30f66af75a1d192fee56852"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3fd13506d4afa01672d14631d209879700377c9db85359ef9a239fac4a03bf7" => :catalina
    sha256 "f384c7a1c85212402bbfcd8bdd31f56a69d9e4d4b5045fdafa2fc54cf0a9814e" => :mojave
    sha256 "37360db27c990fe31770b360022cfdcd9601ad2fe863a617b86a079f2ef0bd3c" => :high_sierra
    sha256 "bb8104493ee03726bba6587859826d35b7081cc550b7a958c6698065f87d8c8f" => :sierra
  end

  def install
    # scdoc sets by default LDFLAGS=-static which doesn't work on macos(x)
    system "make", "LDFLAGS=", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    preamble = <<~'EOF'
      .\" Generated by scdoc 1.10.0
      .ie \n(.g .ds Aq \(aq
      .el       .ds Aq '
      .nh
      .ad l
      .\" Begin generated content:
    EOF
    assert_equal preamble, shell_output("#{bin}/scdoc </dev/null")
  end
end