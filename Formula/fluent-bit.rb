class FluentBit < Formula
  desc "Data Collector for IoT"
  homepage "https://github.com/fluent/fluent-bit"
  url "https://github.com/fluent/fluent-bit/archive/v0.12.19.tar.gz"
  sha256 "000d6aba775a8184d6d8f6523eadd4dbd6f91f3d1a02ce42dc683964a29ff2fb"
  head "https://github.com/fluent/fluent-bit.git"

  bottle do
    cellar :any
    sha256 "12cb73e8117d81c7ae5b7cd4adafc0dcca0aca3a13219772e56273f6ae39d225" => :high_sierra
    sha256 "fcfbe096c94f8f5b5d3b3fa9d69695b70f4ebde416d362b0b4345563895a5eda" => :sierra
    sha256 "9c61cd9242df2fc7ad8362a7e2c63ea38bef0eaf6e5d64ad7c00bbd187e5e82c" => :el_capitan
  end

  depends_on "cmake" => :build

  conflicts_with "mbedtls", :because => "fluent-bit includes mbedtls libraries."
  conflicts_with "msgpack", :because => "fluent-bit includes msgpack libraries."

  def install
    system "cmake", ".", "-DWITH_IN_MEM=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/fluent-bit -V").chomp
    assert_equal "Fluent Bit v#{version}", output
  end
end
