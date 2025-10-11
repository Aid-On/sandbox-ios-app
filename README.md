# AidOn Sandbox - Modern iOS SwiftUI App Template

[![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.10+-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Native-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[🇯🇵 日本語版はこちら](README.ja.md)

A modern iOS application template built with SwiftUI, featuring automated CI/CD, architectural linting, and TestFlight deployment.

## ✨ Features

- **🎨 Pure SwiftUI Architecture** - No UIKit dependencies
- **📦 Swift Package Manager** - Modern dependency management
- **🏗️ Harmonize Linting** - Architectural rules as unit tests
- **🚀 Automated CI/CD** - One-command TestFlight deployment
- **🔐 Code Signing** - Automated with fastlane match
- **👥 Team Development** - Ready for collaborative development

## 🛠 Tech Stack

- **Language**: Swift 5.10
- **UI Framework**: SwiftUI (iOS 16+)
- **Architecture**: MVVM with ObservableObject
- **Linting**: Harmonize (architectural rules) + swift-format
- **CI/CD**: fastlane + Ruby 3.4.5
- **Package Management**: Swift Package Manager
- **Code Signing**: fastlane match with SSH

## 📱 Dependencies

- **Alamofire** - HTTP networking
- **SwiftyJSON** - JSON parsing
- **Kingfisher** - Image loading and caching
- **Harmonize** - Architectural linting

## 🚀 Quick Start

### Prerequisites

- **macOS 14+** (for TestFlight deployment)
- **Xcode 16+** (with iOS 18 SDK)
- **Ruby 3.3+** (managed with mise/rbenv)
- **Apple Developer Account**

### Setup

1. **Clone the repository**
   ```bash
   git clone git@github.com:Aid-On/sandbox-app.git
   cd sandbox-app
   ```

2. **Install dependencies**
   ```bash
   make setup
   ```

3. **Configure environment**
   ```bash
   cp .envrc.sample .envrc
   # Edit .envrc with your Apple Developer credentials
   ```

4. **Generate Xcode project**
   ```bash
   make dev
   ```

5. **Open in Xcode**
   ```bash
   open "AidOn Sandbox.xcodeproj"
   ```

## 📋 Available Commands

```bash
# Development
make help           # Show all available commands
make setup          # Complete project setup
make dev            # Quick development setup
make build          # Build Swift package
make test           # Run tests
make lint           # Run code quality checks
make validate       # Run all validation (tests + linting)

# Code Quality
make lint-architecture  # Run Harmonize architectural tests
make format            # Auto-format code

# Distribution
make testflight-setup  # Setup app in App Store Connect
make testflight       # Build and upload to TestFlight
make archive          # Create app archive

# Utilities
make clean            # Clean build artifacts
make check-env        # Check environment variables
make info             # Show project information
```

## 🏗 Architecture

This template follows modern iOS development best practices:

- **SwiftUI-First**: No legacy UIKit code
- **MVVM Pattern**: Clear separation of concerns
- **Dependency Injection**: Testable architecture
- **Modern Swift**: async/await, actors, structured concurrency
- **Package-Based**: Modular code organization

## 🔧 Configuration

### Environment Variables

Copy `.envrc.sample` to `.envrc` and configure:

```bash
# App Configuration
export APP_NAME="Your App Name"
export APP_ID="com.yourcompany.yourapp"
export APPLE_TEAM_ID="YOUR_TEAM_ID"
export APPLE_ID_MAIL_ADDRESS="your-apple-id@email.com"

# Environment
export XCODE_DEPLOYMENT_TARGET="16.0"
```

### Code Signing

1. Create a private repository for certificates
2. Update `fastlane/Matchfile` with your repository URL
3. Run `make match` to setup code signing

## 🧪 Testing

This template includes comprehensive testing:

- **Unit Tests**: AppCore functionality
- **Architectural Tests**: Harmonize rules
- **Swift Package Tests**: Package manager integration

```bash
make test              # Run all tests
make test-coverage     # Run tests with coverage
make lint-architecture # Check architectural rules
```

## 🚀 Deployment

### TestFlight Deployment

```bash
# One-time setup
make testflight-setup

# Deploy to TestFlight
make testflight
```

### CI/CD Integration

For GitHub Actions, see the workflow example in `SETUP.md`.

## 📖 Documentation

- [Setup Guide](SETUP.md) - Detailed setup instructions
- [Harmonize Tests](Tests/HarmonizeTests/) - Architectural rules
- [Fastlane Configuration](fastlane/) - CI/CD setup

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Run tests (`make validate`)
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with modern iOS development best practices
- Inspired by the latest Swift and SwiftUI patterns
- Harmonize for architectural linting
- fastlane for automated deployment

---

**Note**: This template requires macOS 14+ and Xcode 16+ for TestFlight deployment due to Apple's iOS 18 SDK requirement. For legacy system support, see [SETUP.md](SETUP.md).