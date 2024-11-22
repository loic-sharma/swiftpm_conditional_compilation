# How to conditionally compile code in a Flutter plugin using Swift Package Manager

Sometimes it's useful to have "optional" code in a plugin that the app can
opt-out.

For example, camera access requires user consent. Apps that don't need this
optional camera feature might want to remove this feature to reduce the app's
permissions.

Here's how a plugin might do this:

```swift
#if MY_CAMERA_FEATURE_ENABLED
public func useCamera() {
  // ...
}
#endif
```

In this example, the `useCamera` function is included in the compilation only if
`MY_CAMERA_FEATURE_ENABLED` is defined.

In CocoaPods, the `MY_CAMERA_FEATURE_ENABLED` can be defined by
[customizing targets' build settings].

Unfortunately, Swift Package Manager doesn't support conditional compilation
yet.
A proposal to add [package traits] is currently under review, but it is unclear
when this feature will be available.

[customizing targets' build settings]: https://guides.cocoapods.org/syntax/podfile.html#post_install
[package traits]: https://github.com/swiftlang/swift-evolution/blob/main/proposals/0450-swiftpm-package-traits.md

### Hacky workaround

Here's a hack to add conditional compilation to your Swift package:

1. Update your `Package.swift` file to define `MY_CAMERA_FEATURE_ENABLED` if
   the `MY_CAMERA_FEATURE_ENABLED` environment variable is set to `1`:

   ```diff
    // swift-tools-version: 5.9
    // The swift-tools-version declares the minimum version of Swift required to build this package.
   
    import PackageDescription
   +import Foundation
   +
   +var swiftSettings: [SwiftSetting] = []
   +
   +if ProcessInfo.processInfo.environment["MY_CAMERA_FEATURE_ENABLED"] == "1" {
   +    swiftSettings.append(.define("MY_CAMERA_FEATURE_ENABLED"))
   +}
    
    let package = Package(
       name: "my_plugin",
       platforms: [],
       products: [],
       dependencies: [],
       targets: [
           .target(
               name: "my_plugin",
               dependencies: [],
   -            resources: []
   +            resources: [],
   +            swiftSettings: swiftSettings
           )
       ]
   )
   ```

2. Clean your previous Xcode compilation so that your Swift package is rebuilt.

   ```console
   flutter clean
   ```

3. Run your app with the `MY_CAMERA_FEATURE_ENABLED` environment variable.

   Using the command line:

   ```
   MY_CAMERA_FEATURE_ENABLED=1 flutter run
   ```

   Or, using VS Code launch configurations:

   ```json
   {
     "configurations": [
       {
         "name": "Flutter",
         "request": "launch",
         "type": "dart",
         "env": {
           "MY_CAMERA_FEATURE_ENABLED": "1"
         }
      }
    ]
   }
   ```

> [!WARNING]
> Swift Package Manager does not automatically rebuild your Swift package
> when the value of `MY_CAMERA_FEATURE_ENABLED` changes.
>
> You must run `flutter clean` whenever the value of
> `MY_CAMERA_FEATURE_ENABLED` changes!
>
> You must also run `flutter clean` if you switch between different projects
> that use your plugin with different `MY_CAMERA_FEATURE_ENABLED` values.
