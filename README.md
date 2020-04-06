# Photon-v2-ThirdParty

This repository holds source code of third-party libraries used by [Photon-v2 Renderer](https://github.com/TzuChieh/Photon-v2) as well as utilities for building them. Please note that the libraries and versions listed below are what our custom modifications based on; visit each __custom fork__ link for the actual sources in use.

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

## Build

All third-party libraries should be built to
1. Link against the same version of dependent libraries
2. With settings compatible with the renderer to avoid possible conflicts. Currently, we have CMake scripts that handle the build settings/process for you.

If you wish to compile the libraries by yourself, please try to adhere to the settings listed in [Photon-v2-ThirdParty-Prebuilt](https://github.com/TzuChieh/Photon-v2-ThirdParty-Prebuilt).

## License

See each library's corresponding project site for more detail. This building utility is in [The MIT License](LICENSE).
