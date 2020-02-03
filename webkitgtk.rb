# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Webkitgtk < Formula
  desc ""
  homepage ""
  url "https://webkitgtk.org/releases/webkitgtk-2.26.3.tar.xz"
  sha256 "add51153943cc11d90a7038d0ea5f6332281e6c0be0640f802a211b035f0e611"

  # depends_on "cmake" => :build

  head do
    url "https://github.com/WebKit/webkit.git"

    depends_on "cmake" => :build
    depends_on "gtk+3"
    depends_on "libsoup"
    depends_on "autoconf"
    depends_on "automake"
    depends_on "bison"
    depends_on "enchant"
    depends_on "flex"
    depends_on "gettext"
    depends_on "gobject-introspection"
    depends_on "icu4c"
    depends_on "intltool"
    depends_on "itstool"
    depends_on "libcroco"
    depends_on "libgcrypt"
    depends_on "libgpg-error"
    depends_on "libtasn1"
    depends_on "libtiff"
    depends_on "libtool"
    depends_on "ninja"
    depends_on "pango"
    depends_on "pkg-config"
    depends_on "sqlite"
    depends_on "webp"
    depends_on "xz"
  end

  def install
    # https://github.com/WebKit/webkit#building-gtk-port

    ENV.delete "SDKROOT"

    # turn introspection support OFF until we figure out how to fix it
    extra_args = %w[
      -DENABLE_INTROSPECTION=OFF
      -DPORT=GTK
      -DENABLE_X11_TARGET=OFF
      -DENABLE_QUARTZ_TARGET=ON
      -DENABLE_TOOLS=ON
      -DENABLE_MINIBROWSER=ON
      -DENABLE_PLUGIN_PROCESS_GTK2=OFF
      -DENABLE_VIDEO=OFF
      -DENABLE_WEB_AUDIO=OFF
      -DENABLE_CREDENTIAL_STORAGE=OFF
      -DENABLE_GEOLOCATION=OFF
      -DENABLE_OPENGL=OFF
      -DENABLE_GRAPHICS_CONTEXT_3D=OFF
      -DUSE_LIBNOTIFY=OFF
      -DUSE_LIBHYPHEN=OFF
      -DCMAKE_SHARED_LINKER_FLAGS=-L/path/to/nonexistent/folder
    ]

    mkdir "build" do
      system "cmake", "..", *(std_cmake_args + extra_args)
      system "make", "install"
    end
    system "pwd"
    system "Tools/Scripts/update-webkitgtk-libs"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test webkitgtk`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
