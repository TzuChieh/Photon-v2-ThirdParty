# Photon-v2-ThirdParty

This repository holds source code of third-party libraries used by [Photon-v2 renderer](https://github.com/TzuChieh/Photon-v2) as well as utilities for building them. Here is a list of libraries with the used versions and settings:

Header-only:

* [stb](https://github.com/nothings/stb)
  * git commit hash `e6afb9cbae4064da8c3e69af3ff5c4629579c1d2`
* [Asio](https://github.com/chriskohlhoff/asio)
  * git tag `asio-1-14-0`

Pre-compiled:

* [googletest](https://github.com/google/googletest)
  * git commit hash `a868e618c0607259c63f37d948b72586a13922ff`
* [StackWalker](https://github.com/JochenKalmbach/StackWalker)
  * git commit hash `42e7a6e056a9e7aca911a7e9e54e2e4f90bc2652`
* [libsimdpp](https://github.com/p12tic/libsimdpp)
  * git tag `v2.1`
* [zlib](https://github.com/madler/zlib)
  * git tag `v1.2.11`
* [openexr](https://github.com/openexr/openexr)
  * git tag `v2.4.1`

## Build

All third-party libraries should be built to
1. Link against the same version of dependent libraries
2. With settings compatible with the renderer 
to avoid possible conflicts. Currently, we have CMake scripts that handle the build settings/process for you.

If you need to compile the libraries by yourself, please try to adhere to the settings listed in [Photon-v2-ThirdParty-Prebuilt](https://github.com/TzuChieh/Photon-v2-ThirdParty-Prebuilt).

## License

See each library's corresponding project site for more detail. This building utility is in [The MIT License]("./LICENSE").
