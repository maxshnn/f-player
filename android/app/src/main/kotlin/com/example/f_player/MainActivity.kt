package com.example.f_player

import android.database.Cursor
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "audio_files"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "getAudioFiles") {
                val audioFiles = getAudioFiles()
                result.success(audioFiles)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAudioFiles(): List<String> {
        val audioList = mutableListOf<String>()
        val selection = "${MediaStore.Audio.Media.IS_MUSIC} != 0"
        val projection = arrayOf(MediaStore.Audio.Media.DATA, MediaStore.Audio.Media.DISPLAY_NAME)

        val cursor: Cursor? =
                contentResolver.query(
                        MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                        projection,
                        selection,
                        null,
                        null
                )

        cursor?.use {
            while (it.moveToNext()) {
                val songUrl = it.getColumnIndex(MediaStore.Audio.Media.DATA)
                // val songName = it.getColumnIndex(MediaStore.Audio.Media.DISPLAY_NAME)
                val filePath = it.getString(songUrl)
                audioList.add(filePath)
            }
        }

        return audioList
    }
}
