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

                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                        .setMethodCallHandler { call, result ->
                                if (call.method == "getAudioFiles") {
                                        val audioFiles = getAudioFiles()
                                        result.success(audioFiles)
                                } else {
                                        result.notImplemented()
                                }
                        }
        }

        private fun getAudioFiles(): List<Map<String, Any>> {
                val audioList = mutableListOf<Map<String, Any>>()
                val selection = "${MediaStore.Audio.Media.IS_MUSIC} != 0"
                val projection =
                        arrayOf(
                                MediaStore.Audio.Media.DATA,
                                MediaStore.Audio.Media.DISPLAY_NAME,
                                MediaStore.Audio.Media.TITLE,
                                MediaStore.Audio.Media.TRACK,
                                MediaStore.Audio.Media.SIZE,
                                MediaStore.Audio.Media.MIME_TYPE,
                                MediaStore.Audio.Media.DURATION,
                                MediaStore.Audio.Media.ARTIST,
                                MediaStore.Audio.Media.ALBUM
                        )

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
                                val filePath =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.DATA
                                                )
                                        )
                                val displayName =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.DISPLAY_NAME
                                                )
                                        )
                                val title =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.TITLE
                                                )
                                        )
                                val track =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.TRACK
                                                )
                                        )
                                val fileSize =
                                        it.getLong(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.SIZE
                                                )
                                        )
                                val mimeType =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.MIME_TYPE
                                                )
                                        )
                                val duration =
                                        it.getLong(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.DURATION
                                                )
                                        )
                                val artist =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.ARTIST
                                                )
                                        )
                                val album =
                                        it.getString(
                                                it.getColumnIndexOrThrow(
                                                        MediaStore.Audio.Media.ALBUM
                                                )
                                        )

                                val audioFile =
                                        mapOf(
                                                "path" to filePath,
                                                "title" to title,
                                                "track" to track,
                                                "displayName" to displayName,
                                                "size" to fileSize,
                                                "mimeType" to mimeType,
                                                "duration" to duration,
                                                "artist" to artist,
                                                "album" to album
                                        )

                                audioList.add(audioFile)
                        }
                }

                return audioList
        }
}
