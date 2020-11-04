#![cfg(target_os = "android")]
#![allow(non_snake_case)]

use crate::hello;
use std::ffi::{CString, CStr};
use jni::JNIEnv;
use jni::objects::{JClass, JString};
use jni::sys::jstring;
use std::os::raw::c_char;

// Remember the JNI naming conventions.

#[no_mangle]
pub extern "system" fn Java_com_yongf_lib_1rusty_RustyKt_helloDirect(
    env: JNIEnv,
    _: JClass,
    input: JString,
) -> jstring {
    let input: String = env.get_string(input).expect("Couldn't get Java string!").into();
    let output = env.new_string(format!("Hello from Rust: {}", input))
        .expect("Couldn't create a Java string!");
    output.into_inner()
}

#[allow(clippy::similar_names)]
#[no_mangle]
pub extern "system" fn Java_com_yongf_lib_1rusty_RustyKt_hello(
    env: JNIEnv,
    _: JClass,
    input: JString,
) -> jstring {
    let java_str = env.get_string(input).expect("Couldn't get Java string!");

    let java_str_ptr = java_str.as_ptr();
    let result = unsafe {
        hello(java_str_ptr)
    };

    let result_ptr = unsafe {
        CString::from_raw(result)
    };
    let result_str = result_ptr.to_str().unwrap();
    let output = env.new_string(result_str).expect("Couldn't create a Java string!");
    output.into_inner()
}

#[no_mangle]
pub extern "system" fn rust_greeting(to: *const c_char) -> *mut c_char {
    let c_str = unsafe { CStr::from_ptr(to) };
    let recipient = match c_str.to_str() {
        Err(_) => "oops, something wrong happened.",
        Ok(string) => string,
    };
    CString::new("Hello from rust greeting: ".to_owned() + recipient).unwrap().into_raw()
}

#[no_mangle]
pub extern "system" fn cstring_free(str: *mut c_char) {
    unsafe {
        if str.is_null() {
            return;
        }
        CString::from_raw(str)
    };
}
