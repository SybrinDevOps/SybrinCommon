// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Sybrin.iOS.Common", // Your package name
    platforms: [
        .iOS(.v10)//.iOS(.v13) // Make sure to include this to specify the platform (adjust the version as necessary)
    ],
    products: [
        .library(
            name: "SybrinIOSCommon",
            targets: ["SybrinIOSCommon"]),
    ],
    dependencies: [
        // Add dependencies here if needed
        // "UIKit",
        // "Foundation",
        // "AVFoundation"
    ],
    targets: [
        .target(
            name: "SybrinIOSCommon",
            dependencies: [],
            path: "Sources/Sybrin.iOS.Common",  // Path to your sources
            exclude: ["Supporting Files/Info.plist", "Supporting Files/Fonts/Roboto/LICENSE.txt"],  // Exclude any unnecessary files
            sources: [
                "Extensions/AVCaptureDevicePosition.swift", 
                "Extensions/AVCaptureVideoOrientation.swift",
                "Extensions/CMSampleBuffer.swift",
                "Extensions/CMSampleBuffer.swift",
                "Extensions/Date.swift",
                "Extensions/NSRegularExpression.swift",
                "Extensions/String.swift",
                "Extensions/StringProtocol.swift",
                "Extensions/UIDevice.swift",
                "Extensions/UIDeviceOrientation.swift",
                "Extensions/UIFont.swift",
                "Extensions/UIImage.swift",
                "Extensions/UIImageOrientation.swift",
                "Extensions/UIView.swift",
                "Extensions/UIViewController.swift"
                ],
            
            resources: [
                .process("Supporting Files/Assets.xcassets"),
                .process("Supporting Files/Sybrin_iOS_Common.h"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Black.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-BlackItalic.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Bold.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-BoldItalic.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Light.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-LightItalic.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-MediumItalic.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Medium.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Regular.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-RegularItalic.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-Thin.ttf"),
                .process("Supporting Files/Fonts/Roboto/Roboto-ThinItalic.ttf"),
            ],  // Add resources if necessary (like assets or storyboards)
            publicHeadersPath: nil,
            linkerSettings: []),
    ]
)
