<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Hi, this is a simple library to replace Firebase Remote Config. 

## Features

Sync data from a json file in your server, store date on a local database and then use it in your app in a simple way.

## Getting started

Download the code and make a reference in the pubspect.yaml file:
```yaml
rod_remote_config:
    path: your_path/rod_remote_config_flutter
```

## Usage

Create an instance of RodRemoteConfig and fetch config
to `/example` folder.

```dart
final remoteConfig = RodRemoteConfig();
final result = await remoteConfig.fetchConfig(
        configUrl: "https://yourfile.json",
        cacheDuration: Duration.zero);
// Use your data config:
final friends = await remoteConfig.getListValue('friends');

// Use your data with a default value:
final friends = await remoteConfig.getStringValueDefault('name', 'Default name');
```

## Additional information

The json is saved in a plain text file. 