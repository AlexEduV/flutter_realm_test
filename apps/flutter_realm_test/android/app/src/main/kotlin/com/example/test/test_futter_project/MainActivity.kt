package com.example.test.test_futter_project

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onResume() {
        super.onResume()

        //when revoking the location permissions, Android system kills the process.
        //but the flutter engine is still running, so there was an empty app. This function kills inactive app.
        //if the user wants to, he can relaunch the app again.

        //if tested under android, it looks fine, if under flutter - not so much.
        // but I have already tried to do something onResume in flutter, or in main - it does not work.
        // need to see the logCat for details. Removed background location - still nothing.
        // launch mode - singleTask in the manifest did not work. This has worked partially.

        flutterEngine?.dartExecutor?.isExecutingDart?.let {
            if (!(it)) {
                val intent = packageManager
                    .getLaunchIntentForPackage(packageName)
                intent?.addFlags(
                    Intent.FLAG_ACTIVITY_NEW_TASK or
                            Intent.FLAG_ACTIVITY_CLEAR_TASK
                )
                startActivity(intent)
                finish()
            }
        }
    }
}
