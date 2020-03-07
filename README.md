# Photon-v2-ThirdParty

This repository holds source code of third-party libraries used by [Photon-v2 renderer](https://github.com/TzuChieh/Photon-v2). Here is the list of libraries as well as the used versions and settings:

Header-only libraries:

* [stb](https://github.com/nothings/stb)
  * git commit hash `e6afb9cbae4064da8c3e69af3ff5c4629579c1d2`
* [Asio](https://github.com/chriskohlhoff/asio)
  * git tag `asio-1-14-0`
  * define `ASIO_STANDALONE` so that Boost is not required

Pre-compiled libraries:

* [googletest](https://github.com/google/googletest)
  * git commit hash `a868e618c0607259c63f37d948b72586a13922ff`
* [StackWalker](https://github.com/JochenKalmbach/StackWalker)
  * git commit hash `42e7a6e056a9e7aca911a7e9e54e2e4f90bc2652`
* [libsimdpp](https://github.com/p12tic/libsimdpp)
  * git tag `v2.1`
* [zlib](https://github.com/madler/zlib)
  * git tag `v1.2.11`
* [openexr](https://github.com/openexr/openexr)
  * git tag `v2.3.0`
  * python binding is not needed (define `OPENEXR_BUILD_PYTHON_LIBS=OFF` in CMake)

## Build

All libraries should be built (except for header-only libraries) for static linking to avoid possible conflicts and with settings compatible with the renderer. Currently, pre-compiled libraries are produced under the following environments:

* Windows
  * Visual Studio 2017
* Linux
  * Ubuntu 16.04 with g++ 7.3.0
* macOS
  * High Sierra 10.13 with Apple LLVM version 10.0.0 (clang-1000.10.44.4), target: x86_64-apple-darwin17.0.0, thread model: posix
  * When it comes to apple's toolchain versioning, [this](https://gist.github.com/yamaya/2924292) is a good reference

If you need to compile the libraries by yourself, please try to adhere to the settings listed here as close as possible. This will ensure the libraries work well with the render engine and easier for me to debug if you got into any trouble using Photon-v2.

## License

See each library's corresponding project site for more detail. Licenses (if present) are also included in each library's folder.
