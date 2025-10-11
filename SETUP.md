# Sandbox App - Development Setup

## Prerequisites

### 1. Ruby Environment
Install a Ruby version manager (choose one):

**Option A: mise (recommended)**
```bash
# Install mise
curl https://mise.run | sh

# Install Ruby
mise install ruby@3.4.5
```

**Option B: rbenv**
```bash
# Install rbenv
brew install rbenv

# Install Ruby
rbenv install 3.4.5
rbenv global 3.4.5
```

### 2. iOS Development Tools
- Xcode 15.0+
- Xcode Command Line Tools: `xcode-select --install`
- Apple Developer Account access

## Quick Start

1. **Clone and setup**
   ```bash
   git clone <repository>
   cd ios-app-template
   ```

2. **Install dependencies**
   ```bash
   make setup
   ```

3. **Configure environment**
   Copy `.envrc.sample` to `.envrc` and update:
   - `APPLE_ID_MAIL_ADDRESS` - Your Apple ID
   - `APPLE_TEAM_ID` - Team ID (already set to XT522XX64M)

4. **Activate Ruby environment (mise users)**
   ```bash
   eval "$(mise activate bash)"  # or zsh
   ```

5. **Generate Xcode project**
   ```bash
   make dev
   ```

5. **Open in Xcode**
   ```bash
   open Sandbox.xcodeproj
   ```

## TestFlight Deployment

1. **Setup app in App Store Connect**
   ```bash
   make testflight-setup
   ```

2. **Build and upload**
   ```bash
   make testflight
   ```

## Common Commands

- `make help` - Show all available commands
- `make build` - Build Swift package
- `make test` - Run tests
- `make lint` - Run code quality checks
- `make clean` - Clean build artifacts

## Troubleshooting

### Ruby Issues
If you get Ruby version errors, ensure your Ruby manager is properly configured:

```bash
# For mise users
mise current ruby

# For rbenv users  
rbenv version
```

### Bundler Issues
```bash
gem install bundler
bundle install
```

### Fastlane Issues
```bash
bundle exec fastlane --version
```

## Team Configuration

Each team member should:
1. Set up their own `.envrc` file (never commit this!)
2. Use the same Ruby version (3.4.5)
3. Run `make setup` after cloning