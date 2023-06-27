# competitor_analysis

This is a Etsy, competitor analysis program.

## Getting Started
```
flutter run -d emulator-5554

flutter run -d windows
```
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [UI SOURCE: Fluent_ui](https://github.com/bdlukaa/fluent_ui)
<a title="Made with Fluent Design" href="https://github.com/bdlukaa/fluent_ui">
  <img
    src="https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7"
  >
</a>

For some issues:
- If you against to some Fluent_ui errors when running on dekstop app. You can check your flutter channel ```flutter channel``` and if its not in stable channel you cna swich your channel with ```flutter channel stable``` command and after that run ```flutter upgrade```.
- Enable desktop support, on project root run this commands:
 ```flutter config --enable-windows-desktop```
```flutter config --enable-macos-desktop```
```flutter config --enable-linux-desktop```

For some other issues:
- If your Flutter version is 3.10.5 adn Dart SDK version is 3.0.5 then you should downgrade to 3.7.11 or 3.7.8 it depends on your system.
  ```flutter downgrade <flutter-version>```
