cmake_minimum_required(VERSION 3.5)
project(ProjectName)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

add_library( MNN SHARED IMPORTED )
set_target_properties(
        MNN
        PROPERTIES IMPORTED_LOCATION
        ${PROJECT_SOURCE_DIR}/libs/x86/libMNN.dylib
)

add_library( MNNTrain SHARED IMPORTED )
set_target_properties(
        MNNTrain
        PROPERTIES IMPORTED_LOCATION
        ${PROJECT_SOURCE_DIR}/libs/x86/libMNNTrain.dylib
)

add_library( MNN_Express SHARED IMPORTED )
set_target_properties(
        MNN_Express
        PROPERTIES IMPORTED_LOCATION
        ${PROJECT_SOURCE_DIR}/libs/x86/libMNN_Express.dylib
)

add_executable(demo src/demo.cpp)
target_include_directories(demo PUBLIC includes includes/MNN includes/MNNTrain)
target_link_libraries(demo MNN)
target_link_libraries(demo MNNTrain)
target_link_libraries(demo MNN_Express)