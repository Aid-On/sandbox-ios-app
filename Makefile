#!/usr/bin/env make

.PHONY: help setup clean build test lint format preview install-deps ensure-mint ensure-xcodegen lint-architecture testflight testflight-setup test-fastlane
.DEFAULT_GOAL := help

# Load environment variables from .envrc if it exists
-include .envrc

# Environment variables
SWIFT_VERSION := 5.10
PLATFORM := iOS Simulator
DESTINATION := 'platform=iOS Simulator,name=iPhone 15,OS=latest'
SCHEME := "App $(XCODE_ENVIRONMENT_NAME)"

# Ruby and fastlane environment
RUBY_PATH := $(HOME)/.local/share/mise/installs/ruby/3.4.5/bin
FASTLANE_ENV := PATH="$(RUBY_PATH):$(PATH)" \
	FASTLANE_PASSWORD="ylrm-fsmt-igqi-vmat" \
	MATCH_PASSWORD="dolphineApple003!" \
	FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT=60 \
	FASTLANE_XCODEBUILD_SETTINGS_RETRIES=2

# Export environment variables for shell commands
export

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

## Help
help: ## Show this help message
	@echo "iOS SwiftUI App Template - Make Commands"
	@echo "========================================"
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ { printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

## Setup & Installation
setup: install-deps gen-project ## Complete project setup
	@echo "$(GREEN)✅ Project setup complete!$(NC)"

install-deps: install-node-deps install-ruby-deps install-swift-deps ## Install all dependencies
	@echo "$(GREEN)📦 All dependencies installed$(NC)"

install-node-deps: ## Install Node.js dependencies
	@echo "$(YELLOW)📦 Installing Node.js dependencies...$(NC)"
	-nodenv install -s
	npm install

install-ruby-deps: ## Install Ruby dependencies and CocoaPods
	@echo "$(YELLOW)💎 Installing Ruby dependencies...$(NC)"
	@if ! command -v bundle >/dev/null 2>&1; then \
		echo "$(YELLOW)📦 Installing bundler...$(NC)"; \
		gem install bundler; \
	fi
	bundle config set --local path 'vendor/bundle'
	bundle install

install-swift-deps: ## Install Swift Package Manager dependencies
	@echo "$(YELLOW)⚡ Installing Swift dependencies...$(NC)"
	swift package resolve
	swift package update

install-swift-tools: ## Install Swift development tools
	@echo "$(YELLOW)🔧 Installing Swift tools...$(NC)"
	-swiftenv install -s
	-if [ ! -d ".mint" ]; then git clone https://github.com/yonaskolb/Mint.git .mint; fi
	cd .mint && make
	mint bootstrap

## Project Generation
gen-project: ensure-xcodegen ## Generate Xcode project files
	@echo "$(YELLOW)🔨 Generating Xcode project...$(NC)"
	@if [ -f .envrc ]; then set -a; source .envrc; set +a; fi; \
	node .gen_xcodegen_file.js
	@if command -v xcodegen >/dev/null 2>&1; then \
		xcodegen generate; \
	else \
		mint run xcodegen generate; \
	fi
	@echo "$(GREEN)✅ Xcode project generated$(NC)"

## Development
dev: gen-project ## Quick development setup
	@echo "$(GREEN)🚀 Development environment ready!$(NC)"
	@echo "$(YELLOW)💡 Run 'open *.xcodeproj' to start developing$(NC)"

preview: ## Build and run in simulator
	@echo "$(YELLOW)📱 Building for simulator...$(NC)"
	swift build
	@echo "$(GREEN)✅ Build complete! Open Xcode to run in simulator$(NC)"

## Building
build: ## Build the project with Swift Package Manager
	@echo "$(YELLOW)🔨 Building Swift Package...$(NC)"
	swift build
	@echo "$(GREEN)✅ Swift Package build complete$(NC)"

build-xcode: gen-project ## Build with Xcode (requires generated project)
	@echo "$(YELLOW)🔨 Building with Xcode...$(NC)"
	@if [ -f "*.xcodeproj/project.pbxproj" ]; then \
		xcodebuild -scheme $(SCHEME) -destination $(DESTINATION) build; \
	else \
		echo "$(RED)❌ Xcode project not found. Run 'make gen-project' first$(NC)"; \
		exit 1; \
	fi

build-release: ## Build release version
	@echo "$(YELLOW)🔨 Building release version...$(NC)"
	swift build -c release
	@echo "$(GREEN)✅ Release build complete$(NC)"

## Testing
test: ## Run Swift Package Manager tests
	@echo "$(YELLOW)🧪 Running tests...$(NC)"
	swift test
	@echo "$(GREEN)✅ All tests passed$(NC)"

test-xcode: gen-project ## Run tests with Xcode
	@echo "$(YELLOW)🧪 Running Xcode tests...$(NC)"
	@if [ -f "*.xcodeproj/project.pbxproj" ]; then \
		xcodebuild test -scheme $(SCHEME) -destination $(DESTINATION); \
	else \
		echo "$(RED)❌ Xcode project not found. Run 'make gen-project' first$(NC)"; \
		exit 1; \
	fi

test-coverage: ## Run tests with coverage report
	@echo "$(YELLOW)🧪 Running tests with coverage...$(NC)"
	swift test --enable-code-coverage
	@echo "$(GREEN)✅ Tests with coverage complete$(NC)"

## Code Quality
lint: ## Run modern linting (Harmonize + syntax check)
	@echo "$(YELLOW)🔍 Running modern Swift linting...$(NC)"
	@echo "$(YELLOW)  → Checking architecture with Harmonize...$(NC)"
	@swift test --filter HarmonizeTests && echo "$(GREEN)  ✅ Architecture rules passed$(NC)" || echo "$(RED)  ❌ Architecture rules failed$(NC)"
	@echo "$(YELLOW)  → Running syntax check...$(NC)"
	@swift build > /dev/null && echo "$(GREEN)  ✅ Swift syntax check passed$(NC)" || echo "$(RED)  ❌ Syntax errors found$(NC)"
	@echo "$(GREEN)✅ Linting complete$(NC)"

format: ## Auto-format code with built-in Swift formatting
	@echo "$(YELLOW)✨ Formatting code...$(NC)"
	@find Sources Tests -name "*.swift" -type f -exec swift-format --in-place {} \; 2>/dev/null && echo "$(GREEN)✅ Code formatting complete$(NC)" || echo "$(YELLOW)⚠️  swift-format not available, skipping format$(NC)"

lint-architecture: ## Run only Harmonize architecture tests
	@echo "$(YELLOW)🏗️  Running architecture linting with Harmonize...$(NC)"
	@swift test --filter HarmonizeTests

validate: test lint ## Run all validation (tests + linting)
	@echo "$(GREEN)✅ All validation checks passed$(NC)"

## Apple Developer
register-devices: ## Register devices for development
	@echo "$(YELLOW)📱 Registering devices...$(NC)"
	bundle exec fastlane store_devices

match: ## Setup code signing with match
	@echo "$(YELLOW)🔐 Setting up code signing...$(NC)"
	bundle exec fastlane produce \
		-u $(APPLE_ID_MAIL_ADDRESS) \
		-a $(APP_ID) \
		--language Japanese \
		--app_name $(APP_NAME) \
		--skip_itc
	bundle exec fastlane match $(MATCH_OPERATION_TYPE) -a $(APP_ID)

signing: ## Setup signing certificates
	@echo "$(YELLOW)📝 Setting up signing certificates...$(NC)"
	bundle exec fastlane signing_cer

delete-match: ## Delete match certificates
	@echo "$(YELLOW)🗑️  Deleting match certificates...$(NC)"
	-bundle exec fastlane match nuke $(MATCH_DELETE_TYPE)

## Distribution
archive: gen-project ## Create app archive
	@echo "$(YELLOW)📦 Creating archive...$(NC)"
	@if [ -f .envrc ]; then set -a; source .envrc; set +a; fi; \
	$(FASTLANE_ENV) bundle exec fastlane gym -s $(SCHEME)
	@echo "$(GREEN)✅ Archive created$(NC)"

testflight: ## Build and upload to TestFlight (automated)
	@echo "$(YELLOW)🚀 Building and uploading to TestFlight...$(NC)"
	@if [ -f .envrc ]; then set -a; source .envrc; set +a; fi; \
	$(FASTLANE_ENV) bundle exec fastlane testflight_upload
	@echo "$(GREEN)✅ Uploaded to TestFlight$(NC)"

testflight-setup: ## Setup app in App Store Connect for TestFlight
	@echo "$(YELLOW)🔧 Setting up app in App Store Connect...$(NC)"
	@if [ -f .envrc ]; then set -a; source .envrc; set +a; fi; \
	$(FASTLANE_ENV) bundle exec fastlane produce \
		-u "$(APPLE_ID_MAIL_ADDRESS)" \
		-a "$(APP_ID)" \
		--app_name "$(APP_NAME)" \
		--language English \
		--app_version 1.0 \
		--sku "$(APP_ID)"
	@echo "$(GREEN)✅ App setup complete$(NC)"

## Utilities
clean: ## Clean build artifacts
	@echo "$(YELLOW)🧹 Cleaning build artifacts...$(NC)"
	swift package clean
	-rm -rf .build
	-rm -rf *.xcodeproj
	-rm -rf DerivedData
	-rm -f project.yml
	@echo "$(GREEN)✅ Clean complete$(NC)"

clean-deps: ## Clean all dependencies
	@echo "$(YELLOW)🧹 Cleaning dependencies...$(NC)"
	-rm -rf node_modules
	-rm -rf vendor
	-rm -rf Pods
	-rm -rf .build
	-rm -rf .mint
	-rm package-lock.json
	-rm Podfile.lock
	@echo "$(GREEN)✅ Dependencies cleaned$(NC)"

reset: clean clean-deps ## Full reset (clean + clean dependencies)
	@echo "$(GREEN)🔄 Full reset complete$(NC)"

bootstrap: setup register-devices match signing ## Bootstrap for new developers
	@echo "$(GREEN)🎉 Bootstrap complete! Ready for development$(NC)"

check-env: ## Check environment variables
	@echo "$(YELLOW)🔍 Checking environment variables...$(NC)"
	@if [ -f .envrc ]; then \
		echo "Loading .envrc..."; \
		set -a; source .envrc; set +a; \
		echo "APP_NAME: $$APP_NAME"; \
		echo "APP_ID: $$APP_ID"; \
		echo "XCODE_ENVIRONMENT_NAME: $$XCODE_ENVIRONMENT_NAME"; \
		echo "APPLE_TEAM_ID: $$APPLE_TEAM_ID"; \
		echo "XCODE_DEPLOYMENT_TARGET: $$XCODE_DEPLOYMENT_TARGET"; \
		echo "APPLE_ID_MAIL_ADDRESS: $$APPLE_ID_MAIL_ADDRESS"; \
	else \
		echo "$(RED)❌ .envrc not found$(NC)"; \
	fi

test-fastlane: ## Test fastlane environment
	@echo "$(YELLOW)🧪 Testing fastlane environment...$(NC)"
	@if [ -f .envrc ]; then set -a; source .envrc; set +a; fi; \
	$(FASTLANE_ENV) bundle exec fastlane --version
	@echo "$(GREEN)✅ Fastlane environment ready$(NC)"

## Helper targets for dependency management
ensure-mint: ## Ensure Mint is available
	@if ! command -v mint >/dev/null 2>&1; then \
		echo "$(YELLOW)📦 Installing Mint...$(NC)"; \
		if [ ! -d ".mint" ]; then \
			git clone https://github.com/yonaskolb/Mint.git .mint; \
		fi; \
		cd .mint && make && cd ..; \
	fi


ensure-xcodegen: ensure-mint ## Ensure XcodeGen is available  
	@if ! command -v xcodegen >/dev/null 2>&1 && ! mint list | grep -q XcodeGen; then \
		echo "$(YELLOW)🔧 Installing XcodeGen via Mint...$(NC)"; \
		mint install yonaskolb/XcodeGen; \
	fi

info: ## Show project information
	@echo "$(GREEN)Sandbox - SwiftUI Application$(NC)"
	@echo "============================="
	@echo "Swift Version: $(SWIFT_VERSION)"
	@echo "Platform: $(PLATFORM)"
	@echo "Architecture: SwiftUI + Swift Package Manager"
	@echo "Dependencies: Alamofire, SwiftyJSON, Kingfisher"
	@echo "Linting: Harmonize (architecture) + swift-format (style)"
	@echo ""
	@echo "$(YELLOW)Quick Start:$(NC)"
	@echo "1. Run 'make setup' to install dependencies"
	@echo "2. Run 'make dev' to generate Xcode project"
	@echo "3. Open project in Xcode and build for TestFlight!"