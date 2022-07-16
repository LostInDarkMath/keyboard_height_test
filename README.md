# keyboard_height_test
I want to compare different packages here, which want to determine the keyboard height for me.
- `MediaQuery.of(context).viewInsets.bottom`
  - [https://stackoverflow.com/a/48751912/10975692](https://stackoverflow.com/a/48751912/10975692)

- `EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio).bottom;`
  - [https://stackoverflow.com/a/64473806/10975692](https://stackoverflow.com/a/64473806/10975692)
  - works well, but not on Android 12 

- [keyboard_utils](https://pub.dev/packages/keyboard_utils)
  - is no longer maintained
  - works fine on iOS but does not work on Android (there is gap about 30 pixels on some devices)

- [flutter_persistent_keyboard_height](https://pub.dev/packages/flutter_persistent_keyboard_height)
  - based on `keyboard_utils` uses basically the maximum of the value from `keyboard_utils` and `MediaQuery.of(context).viewInsets.bottom`
  - not very handy, a bit buggy, no recommendation

- [flutter_keyboard_size](https://pub.dev/packages/flutter_keyboard_size)
  - does not look well maintained 
  - very simple, uses `MediaQuery.of(context).viewInsets.bottom` together with `Provider`

Other packages that are not featured here:
- [keyboard_detection](https://pub.dev/packages/keyboard_detection)
  - it simply uses `MediaQuery.of(context).viewInsets.bottom`

## Testing
- Android 10, Xiaomi A2 Lite: everything works fine except for `keyboard_utils`
- Android 10, Xiaomi A2 Lite with Android 10 gestures: everything works fine except for `keyboard_utils`
- Android 6: everything works fine except for `keyboard_utils` with the workaround
- Android 12 Motorola G22: everything work fine except for `keyboard_utils`
- Android 10 Tablet Lenovo M10: everything works fine except for `keyboard_utils` with the workaround
- Android 12 SM F711B: everything work fine except for `keyboard_utils`
- iOS: TODO

Last edited: 2022-07-13
