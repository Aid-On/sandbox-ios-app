# AidOn Sandbox - モダンな iOS SwiftUI アプリテンプレート

[![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.10+-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Native-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[🇺🇸 English version here](README.md)

SwiftUIで構築された最新のiOSアプリケーションテンプレートです。自動化されたCI/CD、アーキテクチャリンティング、TestFlightデプロイメント機能を備えています。

## ✨ 特徴

- **🎨 純粋SwiftUIアーキテクチャ** - UIKit依存なし
- **📦 Swift Package Manager** - 現代的な依存関係管理
- **🏗️ Harmonizeリンティング** - アーキテクチャルールをユニットテストとして実装
- **🚀 自動化CI/CD** - ワンコマンドでTestFlightデプロイメント
- **🔐 コード署名** - fastlane matchで自動化
- **👥 チーム開発** - 協力開発に最適化

## 🛠 技術スタック

- **言語**: Swift 5.10
- **UIフレームワーク**: SwiftUI (iOS 16+)
- **アーキテクチャ**: MVVM with ObservableObject
- **リンティング**: Harmonize（アーキテクチャルール）+ swift-format
- **CI/CD**: fastlane + Ruby 3.4.5
- **パッケージ管理**: Swift Package Manager
- **コード署名**: fastlane match with SSH

## 📱 依存関係

- **Alamofire** - HTTPネットワーキング
- **SwiftyJSON** - JSONパーシング
- **Kingfisher** - 画像読み込み・キャッシング
- **Harmonize** - アーキテクチャリンティング

## 🚀 クイックスタート

### 前提条件

- **macOS 14+** (TestFlightデプロイメント用)
- **Xcode 16+** (iOS 18 SDK付き)
- **Ruby 3.3+** (mise/rbenvで管理)
- **Apple Developer アカウント**

### セットアップ

1. **リポジトリをクローン**
   ```bash
   git clone git@github.com:Aid-On/sandbox-app.git
   cd sandbox-app
   ```

2. **依存関係をインストール**
   ```bash
   make setup
   ```

3. **環境設定**
   ```bash
   cp .envrc.sample .envrc
   # .envrcにApple Developer認証情報を編集
   ```

4. **Xcodeプロジェクトを生成**
   ```bash
   make dev
   ```

5. **Xcodeで開く**
   ```bash
   open "AidOn Sandbox.xcodeproj"
   ```

## 📋 利用可能なコマンド

```bash
# 開発
make help           # 利用可能なコマンド一覧
make setup          # プロジェクト完全セットアップ
make dev            # 開発環境クイックセットアップ
make build          # Swift パッケージビルド
make test           # テスト実行
make lint           # コード品質チェック
make validate       # 全検証実行（テスト + リンティング）

# コード品質
make lint-architecture  # Harmonizeアーキテクチャテスト実行
make format            # コード自動フォーマット

# 配信
make testflight-setup  # App Store Connectにアプリセットアップ
make testflight       # TestFlightビルド・アップロード
make archive          # アプリアーカイブ作成

# ユーティリティ
make clean            # ビルド成果物クリーンアップ
make check-env        # 環境変数確認
make info             # プロジェクト情報表示
```

## 🏗 アーキテクチャ

このテンプレートは現代的なiOS開発のベストプラクティスに従っています：

- **SwiftUI優先**: レガシーなUIKitコードなし
- **MVVMパターン**: 明確な関心の分離
- **依存関係注入**: テスト可能なアーキテクチャ
- **モダンSwift**: async/await、actors、構造化された並行性
- **パッケージベース**: モジュラーコード構成

## 🔧 設定

### 環境変数

`.envrc.sample`を`.envrc`にコピーして設定：

```bash
# アプリ設定
export APP_NAME="あなたのアプリ名"
export APP_ID="com.yourcompany.yourapp"
export APPLE_TEAM_ID="YOUR_TEAM_ID"
export APPLE_ID_MAIL_ADDRESS="your-apple-id@email.com"

# 環境
export XCODE_DEPLOYMENT_TARGET="16.0"
```

### コード署名

1. 証明書用のプライベートリポジトリを作成
2. `fastlane/Matchfile`にリポジトリURLを更新
3. `make match`を実行してコード署名をセットアップ

## 🧪 テスト

このテンプレートには包括的なテスト機能が含まれています：

- **ユニットテスト**: AppCore機能
- **アーキテクチャテスト**: Harmonizeルール
- **Swift Packageテスト**: パッケージマネージャ統合

```bash
make test              # 全テスト実行
make test-coverage     # カバレッジ付きテスト実行
make lint-architecture # アーキテクチャルールチェック
```

## 🚀 デプロイメント

### TestFlightデプロイメント

```bash
# 初回セットアップ
make testflight-setup

# TestFlightにデプロイ
make testflight
```

### CI/CD統合

GitHub Actionsについては、`SETUP.md`のワークフロー例を参照してください。

## 📖 ドキュメント

- [セットアップガイド](SETUP.md) - 詳細なセットアップ手順
- [Harmonizeテスト](Tests/HarmonizeTests/) - アーキテクチャルール
- [Fastlane設定](fastlane/) - CI/CDセットアップ

## 🤝 コントリビューション

1. リポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. テストを実行 (`make validate`)
4. 変更をコミット (`git commit -m 'Add amazing feature'`)
5. ブランチにプッシュ (`git push origin feature/amazing-feature`)
6. プルリクエストを開く

## 📄 ライセンス

このプロジェクトはMITライセンスの下でライセンスされています - 詳細は[LICENSE](LICENSE)ファイルを参照してください。

## 🙏 謝辞

- 現代的なiOS開発ベストプラクティスで構築
- 最新のSwiftとSwiftUIパターンからインスパイア
- アーキテクチャリンティングにHarmonizeを使用
- 自動デプロイメントにfastlaneを使用

---

**注意**: AppleのiOS 18 SDK要件により、TestFlightデプロイメントにはmacOS 14+ とXcode 16+ が必要です。レガシーシステムサポートについては[SETUP.md](SETUP.md)を参照してください。