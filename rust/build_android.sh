#!/usr/bin/env bash

## attention: NEED REFACTOR TO RUST CLI.

# set the version to use the library
min_version=22
# verify before executing this that you have the proper targets installed
cargo ndk --target aarch64-linux-android --android-platform ${min_version} -- build --release
cargo ndk --target armv7-linux-androideabi --android-platform ${min_version} -- build --release
cargo ndk --target i686-linux-android --android-platform ${min_version} -- build --release
cargo ndk --target x86_64-linux-android --android-platform ${min_version} -- build --release

# moving libraries to the android project
jniLibs=../android/lib-rusty/src/main/jniLibs
libName=librustylib.so

#rm -rf ${jniLibs}

# create dir first if not exist.
if [ ! -d ${jniLibs}/arm64-v8a/${libName} ]; then
  mkdir -p ${jniLibs}/arm64-v8a
fi
if [ ! -d ${jniLibs}/armeabi-v7a/${libName} ]; then
  mkdir -p ${jniLibs}/armeabi-v7a
fi
if [ ! -d ${jniLibs}/x86/${libName} ]; then
  mkdir -p ${jniLibs}/x86
fi
if [ ! -d ${jniLibs}/x86_64/${libName} ]; then
  mkdir -p ${jniLibs}/x86_64
fi

cp target/aarch64-linux-android/release/${libName} ${jniLibs}/arm64-v8a/${libName}
cp target/armv7-linux-androideabi/release/${libName} ${jniLibs}/armeabi-v7a/${libName}
cp target/i686-linux-android/release/${libName} ${jniLibs}/x86/${libName}
cp target/x86_64-linux-android/release/${libName} ${jniLibs}/x86_64/${libName}
