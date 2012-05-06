# SuperPlayer Makefile
PREFIX = .
BUILD_DIR = ${PREFIX}/build
SRC_DIR = ${PREFIX}/src

default:
	make clean build

clean:
	@@echo "Removing the build directory:" ${BUILD_DIR}
	@@rm -rf ${BUILD_DIR}

build:
	@@echo "Building the project in " ${BUILD_DIR} " from " ${SRC_DIR} "..."
	@@coffee --compile --output build/ src/
	@@cp ${PREFIX}/mod.json ${BUILD_DIR}/mod.json