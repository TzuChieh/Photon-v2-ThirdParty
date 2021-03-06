# Photon-v2-ThirdParty

This repository holds source code of third-party libraries used by [Photon-v2 Renderer](https://github.com/TzuChieh/Photon-v2) as well as utilities for building them. Please note that the libraries and versions listed below are what our custom modifications based on; visit each __custom fork__ link for the actual sources in use by [Prebuilt](./Prebuilt/) binaries.

Header-only:

* [stb](https://github.com/nothings/stb)
  * git commit hash `e6afb9cbae4064da8c3e69af3ff5c4629579c1d2`
  * [__custom fork__](https://github.com/TzuChieh/stb/tree/photon)
* [Asio](https://github.com/chriskohlhoff/asio)
  * git tag `asio-1-14-0`
  * [__custom fork__](https://github.com/TzuChieh/asio/tree/photon)

Others:

* [googletest](https://github.com/google/googletest)
  * git commit hash `a868e618c0607259c63f37d948b72586a13922ff`
  * [__custom fork__](https://github.com/TzuChieh/googletest/tree/photon)
* [StackWalker](https://github.com/JochenKalmbach/StackWalker)
  * git commit hash `42e7a6e056a9e7aca911a7e9e54e2e4f90bc2652`
  * [__custom fork__](https://github.com/TzuChieh/StackWalker/tree/photon)
* [zlib](https://github.com/madler/zlib)
  * git tag `v1.2.11`
  * [__custom fork__](https://github.com/TzuChieh/zlib/tree/photon)
* [OpenEXR](https://github.com/openexr/openexr)
  * git commit hash `e23fdf6e02dbd8157b1d468143a82f6632781dee`
  * [__custom fork__](https://github.com/TzuChieh/openexr/tree/photon)
* [glfw](https://github.com/glfw/glfw)
  * git tag `3.3.4`
  * [__custom fork__](https://github.com/TzuChieh/glfw/tree/photon)
* [glad](https://github.com/Dav1dde/glad)
  * we use the glad2 branch, git commit hash `994aa6e4506286131a1383b61c552bc940959917`
  * see [our glad repo readme](https://github.com/TzuChieh/glad/tree/photon) for how the source is generated and corresponding settings in use
  * [__generated source__](https://github.com/TzuChieh/glad/tree/photon)
* [imgui](https://github.com/ocornut/imgui)
  * git tag `v1.83`
  * [__custom fork__](https://github.com/TzuChieh/imgui/tree/photon)

Tools:

* [pkg-config-lite](https://sourceforge.net/projects/pkgconfiglite/)
  * version 0.28-1 (win32)

## Build

Precompiled version is provided in [Prebuilt](./Prebuilt). Libraries as well as the project (Photon-v2) support only x64 build. If you wish to compile the libraries by yourself, please try to adhere to the settings listed below

1. Link against the same version of dependent libraries
2. With settings compatible with the renderer to avoid possible conflicts. Currently, we have CMake scripts that handle the build settings/process for you.
3. Try to build for dynamic linking to avoid conflicts between CRTs

### Current Build Settings

* Windows
  * Visual Studio 2017
* Linux
  * Ubuntu 18.04 with g++ 7.5.0
* macOS
  * High Sierra 10.13 with Apple LLVM version 10.0.0 (clang-1000.10.44.4), target: x86_64-apple-darwin17.0.0, thread model: posix
  * When it comes to apple's toolchain versioning, [this](https://gist.github.com/yamaya/2924292) is a good reference

Using similar environment will ensure the libraries work well with the render engine and easier to debug if you got into any trouble using Photon-v2. Report any errors encountered and I will be there to help you!

## License

See each library's corresponding project site for more detail. This building utility is in [The MIT License](LICENSE).
