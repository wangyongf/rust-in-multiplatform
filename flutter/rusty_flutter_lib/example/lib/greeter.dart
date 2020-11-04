import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

final DynamicLibrary greeterNative = Platform.isAndroid
    ? DynamicLibrary.open("librustylib.so")
    : DynamicLibrary.process();

typedef GreetingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef GreetingFunctionFFI = Pointer<Utf8> Function(Pointer<Utf8>);

final GreetingFunction rustGreeting = greeterNative
    .lookup<NativeFunction<GreetingFunctionFFI>>("rust_greeting")
    .asFunction();

typedef CStringFree = void Function(Pointer<Utf8>);
typedef CStringFreeFFI = Void Function(Pointer<Utf8>);

final CStringFree cstringFree = greeterNative
    .lookup<NativeFunction<CStringFreeFFI>>("cstring_free")
    .asFunction();
