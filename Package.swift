// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AsyncBluetooth",
    platforms: [
        .macOS("11.0"),
        .iOS("14.0")
    ],
    products: [
        .library(
            name: "AsyncBluetooth",
            targets: ["AsyncBluetooth"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/NordicSemiconductor/IOS-CoreBluetooth-Mock.git", from: "0.14.0"),
    ],
    targets: [
        .target(
            name: "AsyncBluetooth",
            dependencies: [.product(name: "CoreBluetoothMock", package: "IOS-CoreBluetooth-Mock")],
            path: "Sources"
        ),
        .testTarget(
            name: "AsyncBluetoothTests",
            dependencies: [
                "AsyncBluetooth",
                    .product(name: "CoreBluetoothMock", package: "IOS-CoreBluetooth-Mock")
            ],
            path: "Tests"
        ),
    ]
)
