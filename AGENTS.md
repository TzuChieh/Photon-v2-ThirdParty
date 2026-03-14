# AGENTS.md - Photon-v2-ThirdParty

## Project Overview

**Photon-v2-ThirdParty** is a central repository for all third-party dependencies used by the [Photon-v2 Renderer](https://github.com/TzuChieh/Photon-v2). It provides a unified way to build and manage these libraries with consistent settings across different platforms (Windows, Linux, and macOS).

The project leverages **Git Submodules** to pull specific versions or custom forks of external libraries and uses **CMake** (specifically `ExternalProject_Add`) to orchestrate their compilation and installation.

### Key Technologies & Libraries
- **Build System:** CMake (3.20+)
- **Language Standard:** C++23 (uses `/std:c++latest` on MSVC)
- **Architecture:** x64 only
- **Linkage:** Shared (`BUILD_SHARED_LIBS=ON`)
- **Main Libraries:**
  - **Asio:** Networking and low-level I/O.
  - **concurrentqueue:** Fast lock-free queue.
  - **glad:** OpenGL loader.
  - **glfw:** Windowing and input.
  - **googletest:** Unit testing framework.
  - **ImGui/implot:** Immediate mode GUI and plotting.
  - **json:** Nlohmann JSON library.
  - **OpenEXR:** High dynamic-range (HDR) image file format.
  - **stb:** Single-file public domain libraries (image loading/writing, etc.).
  - **tracy:** Real-time profiler.

## Building and Running

### Prerequisites
- **Git:** Must be used with submodules.
- **CMake:** Version 3.24 or higher.
- **Compiler:** 
  - Windows: Visual Studio 2022
  - Linux: GCC 14+ or Clang 14+ (requires `libwayland-dev`, `libxkbcommon-dev`, `xorg-dev` for GLFW)
  - macOS: Apple LLVM 10+

### Setup
Ensure all submodules are populated:
```powershell
git submodule update --init --recursive
```

### Build Process
Standard CMake workflow is used to build all libraries:
```powershell
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release --target install
```
The built libraries and headers will be installed into `build/ThirdParty/`.

### Prebuilt Binaries
Precompiled binaries for Windows and Linux are provided in the `Prebuilt/` directory. 
- Use `Prebuilt/unpack.py` to restore symlinks after cloning/downloading.
- Use `Prebuilt/pack.py` if you are updating prebuilt binaries and need to preserve symlink metadata.

## Development Conventions

### Library Management
- **Custom Forks:** Most libraries use custom forks hosted under the `TzuChieh` GitHub organization to include specific modifications for Photon-v2.
- **Consistency:** All libraries **must** be built with the same C++ standard (C++23) and architecture (x64) to avoid ABI compatibility issues.
- **Shared Linkage:** Prefer building libraries as shared objects (`.dll`, `.so`, `.dylib`) to simplify updates and avoid CRT conflicts.
- **Library Prefix:** On Windows, all generated libraries are prefixed with `Photon_` (e.g., `Photon_glfw3.dll`) to avoid naming conflicts with other software (e.g., Blender). This is controlled via `PHOTON_LIBRARY_PREFIX` in the root `CMakeLists.txt` and is only applied when building on Windows.

### Directory Structure
- `[LibraryName]/`: Submodule or source directory for a library.
- `Prebuilt/`: Storage for precompiled binaries categorized by OS.
- `Program/`: Contains standalone tools like the Tracy Profiler and `pkg-config-lite`.
- `CMakeLists.txt`: Root script that defines build flags and uses `ExternalProject_Add` for each dependency.

## Usage in Photon-v2
The main Photon-v2 project is configured to look for these dependencies in the `ThirdParty` install directory or the `Prebuilt` folder. When adding or updating a library, ensure it is correctly added to the root `CMakeLists.txt` and its installation path matches what the renderer expects.
