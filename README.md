# Photon-v2-ThirdParty

This repository holds source code of third-party libraries used by [Photon-v2 Renderer](https://github.com/TzuChieh/Photon-v2) as well as utilities for building them. Please note that the libraries and versions listed below are what our custom modifications based on; visit each __custom fork__ link for the actual sources in use by [Prebuilt](./Prebuilt/) binaries.

Header-only:

* [stb](https://github.com/nothings/stb)
  * git commit hash `e6afb9cbae4064da8c3e69af3ff5c4629579c1d2`
  * [__custom fork__](https://github.com/TzuChieh/stb/tree/photon)
* [Asio](https://github.com/chriskohlhoff/asio)
  * git tag `asio-1-14-0`
  * [__custom fork__](https://github.com/TzuChieh/asio/tree/photon)
* [concurrentqueue](https://github.com/cameron314/concurrentqueue)
  * git commit hash `810f6213a2ee3bbd0c2ff647c28996cfff84df06`
  * [__custom fork__](https://github.com/TzuChieh/concurrentqueue/tree/photon)
* [json](https://github.com/nlohmann/json)
  * git commit hash `6af826d0bdb55e4b69e3ad817576745335f243ca`
  * [__custom fork__](https://github.com/TzuChieh/json/tree/photon)

Others:

* [googletest](https://github.com/google/googletest)
  * git commit hash `9d21db9e0a60a1ea61ec19331c9bc0dd33e907b1`
  * [__custom fork__](https://github.com/TzuChieh/googletest/tree/photon)
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
  * We use the `glad2` branch, git commit hash `b1051403cf81b984f9fc11cc5916adb5afd34766`
  * The source code in our repo is generated--we do not include the source for the generator
  * See [our glad repo readme](https://github.com/TzuChieh/glad/tree/photon) for how the source is generated and corresponding settings in use
  * [__generated source__](https://github.com/TzuChieh/glad/tree/photon)
* [imgui](https://github.com/ocornut/imgui)
  * We use the `docking` branch, git commit hash `8fd0a041355e3cfc6556bbe1e00f262d9a897946`
  * [__custom fork__](https://github.com/TzuChieh/imgui/tree/photon)
* [implot](https://github.com/epezent/implot)
  * We use `v0.15` release, git commit hash `cc5e1da`
  * [__custom fork__](https://github.com/TzuChieh/implot/tree/photon)
* [tracy](https://github.com/wolfpld/tracy)
  * We use `v0.9.1` release, git commit hash `897aec5`
  * [__custom fork__](https://github.com/TzuChieh/tracy/tree/photon)

Tools (in the [Program](./Program) folder):

* [pkg-config-lite](https://sourceforge.net/projects/pkgconfiglite/)
  * Version 0.28-1 (win32)

## Build

Precompiled version is provided in [Prebuilt](./Prebuilt). Libraries as well as the project (Photon-v2) support only x64 build. If you wish to compile the libraries by yourself, please try to adhere to the settings listed below

1. Link against the same version of dependent libraries
2. With settings compatible with the renderer to avoid possible conflicts. Currently, we have CMake scripts that handle the build settings/process for you.
3. Try to build for dynamic linking to avoid conflicts between CRTs

Note that cloning or downloading the repository, by default, will not include submodules. This will cause build errors since some library source is not even there. Use the following command to clone this repository with all submodules included:

> git clone --recursive https://github.com/TzuChieh/Photon-v2-ThirdParty.git

For already cloned repository, run the following command **in the repository's root directory**:

> git submodule update --init --recursive

### Building a Different Branch

As submodules are, in fact, separate git repositories (and this repository simply links to them), directly checkout to other branch will not work as expected (using git version = `2.31.1` at the time of speaking), even with the use of `git checkout --recurse-submodules <branch-name>`. A preferable approach is similar to how the submodules are updated:

1. Clone normally with `git clone https://github.com/TzuChieh/Photon-v2-ThirdParty.git`
2. Checkout normally with `git checkout <branch-name>`
3. Populate the submodules with `git submodule update --init --recursive`

Now the libraries can be built as usual on the chosen branch.

### Current Build Settings

C++ standard in use: C++20
Architecture: x64

* Windows
  * Visual Studio 2019, with Windows SDK 10.0 (10.0 = latest)
* Linux
  * Ubuntu 18.04 with g++ 7.5.0
* macOS
  * High Sierra 10.13 with Apple LLVM version 10.0.0 (clang-1000.10.44.4), target: x86_64-apple-darwin17.0.0, thread model: posix
  * When it comes to apple's toolchain versioning, [this](https://gist.github.com/yamaya/2924292) is a good reference

Using similar environment will ensure the libraries work well with the render engine and easier to debug if you got into any trouble using Photon-v2. Report any errors encountered and I will be there to help you!

## License

See each library's corresponding project site for more detail. This building utility is in [The MIT License](LICENSE).
