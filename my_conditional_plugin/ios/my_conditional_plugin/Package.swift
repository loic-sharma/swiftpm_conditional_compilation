// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

var swiftSettings: [SwiftSetting] = []

if ProcessInfo.processInfo.environment["MY_CONDITIONAL_PLUGIN_SWITCH"] == "1" {
    swiftSettings.append(.define("MY_CONDITIONAL_PLUGIN_SWITCH"))
}

let package = Package(
    name: "my_conditional_plugin",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "my-conditional-plugin", targets: ["my_conditional_plugin"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "my_conditional_plugin",
            dependencies: [],
            resources: [
                // If your plugin requires a privacy manifest, for example if it uses any required
                // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                // privacy impact, and then uncomment these lines. For more information, see
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                // .process("PrivacyInfo.xcprivacy"),

                // If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ],
            swiftSettings: swiftSettings
        )
    ]
)
