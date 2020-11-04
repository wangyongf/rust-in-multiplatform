package com.yongf.rusty_flutter_lib_example

import android.os.Bundle
import android.util.Log
import com.yongf.lib_rusty.hello
import com.yongf.lib_rusty.loadRustyLib
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        loadRustyLib()

        val msg = hello("Scott Wang")
        Log.d(TAG, "onCreate, message: $msg")
    }
    
    companion object {
        private const val TAG = "Main"
    }
}
