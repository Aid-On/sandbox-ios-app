// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Sandbox",
    platforms: [
        .iOS(.v16),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "AppCore",
            targets: ["AppCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
        .package(url: "https://github.com/perrystreetsoftware/Harmonize.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "Alamofire",
                "SwiftyJSON", 
                "Kingfisher"
            ],
            path: "Sources/AppCore"
        ),
        .testTarget(
            name: "AppCoreTests",
            dependencies: ["AppCore"],
            path: "Tests/AppCoreTests"
        ),
        .testTarget(
            name: "HarmonizeTests",
            dependencies: [
                "AppCore",
                .product(name: "Harmonize", package: "Harmonize")
            ],
            path: "Tests/HarmonizeTests"
        ),
    ]
)