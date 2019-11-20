class Coccinelle < Formula
  desc "Program matching and transformation engine for C code"
  homepage "http://coccinelle.lip6.fr/"
  url "https://github.com/coccinelle/coccinelle/archive/1.0.8.tar.gz"
  sha256 "9f994bf98bc88c333ac7a54a03d4fa1826122eec7016a1f22c6b2ef2a6a4347f"

  depends_on "hevea" => :build
  depends_on "opam" => :build
  depends_on "camlp4"
  depends_on "ocaml"
  depends_on "autoconf"
  depends_on "automake"

  def install
    ENV.deparallelize
    ENV["OCAMLPARAM"] = "safe-string=0,_" # OCaml 4.06.0 compat

    opamroot = buildpath/"opamroot"
    ENV["OPAMROOT"] = opamroot
    ENV["OPAMYES"] = "1"
    system "opam", "init", "--no-setup", "--disable-sandboxing"
    system "opam", "install", "ocamlfind"

    system "./autogen"
    system "opam", "config", "exec", "--",
           "./configure", "--disable-dependency-tracking",
                          "--enable-release",
                          "--enable-ocaml",
                          "--enable-opt",
                          "--with-pdflatex=no",
                          "--prefix=#{prefix}"
    system "opam", "config", "exec", "--",
           "make"
    system "make", "install"

    pkgshare.install "demos/simple.cocci", "demos/simple.c"
  end

  test do
    system "#{bin}/spatch", "-sp_file", "#{pkgshare}/simple.cocci",
                            "#{pkgshare}/simple.c", "-o", "new_simple.c"
    expected = <<~EOS
      int main(int i) {
        f("ca va", 3);
        f(g("ca va pas"), 3);
      }
    EOS
    assert_equal expected, (testpath/"new_simple.c").read
  end
end
