# Melos Setup
### Android
Android project ran without a problem on android from the main flutter folder. In Android folder it
had a few warnings about the package name, which changed nothing, and a missing Flutter dependency.
Still, the project worked fine if run from flutter, so I suppressed all the warnings for Kotlin files in the IDE settings.

Java config and Kotlin config are relatively safe.

Now, I can run the project from both flutter and android. Just the syntax will be visible in the Android window.


### iOS
iOS project has had some issues with the pod file. When using `$ melos bs`, the pod file goes into a symlink,
and is not accessible to `pod` commands from the terminal.

If there are issues during migration, I have recreated iOS config
using:

```shell
flutter clean
flutter pub get
# This specifically forces Xcode to re-read the paths
flutter build ios --config-only
```

and then reran the melos setup:

```shell
# From your root directory
melos clean
melos bootstrap
```

```shell
cd apps/flutter_realm_test/ios
rm -rf Pods Podfile.lock .symlinks
pod install
```

And it helped. Maybe I will use it again with the `melos bs` command.



