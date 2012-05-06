# SuperPlayer Makefile
NAME = "SuperPlayer"

PREFIX = .
BUILD_DIR = ${PREFIX}/build
DIST_DIR = ${PREFIX}/dist
DIST_TEMP_DIR = ${DIST_DIR}/temp
SRC_DIR = ${PREFIX}/src

default:
	make clean build dist

.PHONY: clean
clean:
	@@echo "Removing the build directory:" ${BUILD_DIR}
	@@rm -rf ${BUILD_DIR}

.PHONY: build
build:
	@@echo "Building the project in " ${BUILD_DIR} " from " ${SRC_DIR} "..."
	@@coffee --compile --output build/ src/
	@@cp ${PREFIX}/mod.json ${BUILD_DIR}/mod.json

.PHONY: dist
dist:
	@@# Clean directory
	@@echo "Cleaning the distribution directory..."
	@@rm -rf ${DIST_DIR}

	@@echo "Creating a distribution package..."

	@@# Create temp directory
	@@mkdir -p ${DIST_TEMP_DIR}

	@@# Move the files to include
	@@cp -r ${BUILD_DIR}/ ${DIST_DIR}/temp && mv ${DIST_DIR}/temp/build ${DIST_DIR}/temp/${NAME}
	@@cp ${PREFIX}/README.md ${DIST_DIR}/temp

	@@# Zip the stuff
	@@cd ${DIST_TEMP_DIR} && zip -r ../${NAME} .

	@@# Clean temp
	@@rm -rf ${DIST_TEMP_DIR}

	@@echo "Package created in the dist directory: " ${DIST_DIR}