package com.yongf.lib_rusty

external fun hello(msg: String): String
external fun helloDirect(msg: String): String

fun loadRustyLib() {
    System.loadLibrary("rustylib")
}
