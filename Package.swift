// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomTextFieldLibrary",
    platforms: [
        .iOS(.v14) // 지원하는 최소 플랫폼 버전 설정
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CustomTextFieldLibrary",
            targets: ["CustomTextFieldLibrary"]),
    ],
    dependencies: [
        // SnapKit 의존성 추가
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
        // Kingfisher 의존성 추가
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"), // 원하는 버전 지정
    ],
    targets: [
        .target(
            name: "CustomTextFieldLibrary",
            dependencies: ["SnapKit", "Kingfisher"]), // SnapKit과 Kingfisher 의존성 추가
    ]
)
