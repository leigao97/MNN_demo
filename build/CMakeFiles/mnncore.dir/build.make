# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.21.4/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.21.4/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/leigao/Downloads/mnn-demo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/leigao/Downloads/mnn-demo/build

# Include any dependencies generated for this target.
include CMakeFiles/mnncore.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/mnncore.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/mnncore.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mnncore.dir/flags.make

CMakeFiles/mnncore.dir/src/demo.cpp.o: CMakeFiles/mnncore.dir/flags.make
CMakeFiles/mnncore.dir/src/demo.cpp.o: ../src/demo.cpp
CMakeFiles/mnncore.dir/src/demo.cpp.o: CMakeFiles/mnncore.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/leigao/Downloads/mnn-demo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/mnncore.dir/src/demo.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/mnncore.dir/src/demo.cpp.o -MF CMakeFiles/mnncore.dir/src/demo.cpp.o.d -o CMakeFiles/mnncore.dir/src/demo.cpp.o -c /Users/leigao/Downloads/mnn-demo/src/demo.cpp

CMakeFiles/mnncore.dir/src/demo.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mnncore.dir/src/demo.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/leigao/Downloads/mnn-demo/src/demo.cpp > CMakeFiles/mnncore.dir/src/demo.cpp.i

CMakeFiles/mnncore.dir/src/demo.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mnncore.dir/src/demo.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/leigao/Downloads/mnn-demo/src/demo.cpp -o CMakeFiles/mnncore.dir/src/demo.cpp.s

# Object files for target mnncore
mnncore_OBJECTS = \
"CMakeFiles/mnncore.dir/src/demo.cpp.o"

# External object files for target mnncore
mnncore_EXTERNAL_OBJECTS =

mnncore: CMakeFiles/mnncore.dir/src/demo.cpp.o
mnncore: CMakeFiles/mnncore.dir/build.make
mnncore: ../libs/x86/libMNN.dylib
mnncore: ../libs/x86/libMNNTrain.dylib
mnncore: ../libs/x86/libMNN_Express.dylib
mnncore: CMakeFiles/mnncore.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/leigao/Downloads/mnn-demo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable mnncore"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mnncore.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/mnncore.dir/build: mnncore
.PHONY : CMakeFiles/mnncore.dir/build

CMakeFiles/mnncore.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mnncore.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mnncore.dir/clean

CMakeFiles/mnncore.dir/depend:
	cd /Users/leigao/Downloads/mnn-demo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/leigao/Downloads/mnn-demo /Users/leigao/Downloads/mnn-demo /Users/leigao/Downloads/mnn-demo/build /Users/leigao/Downloads/mnn-demo/build /Users/leigao/Downloads/mnn-demo/build/CMakeFiles/mnncore.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/mnncore.dir/depend

