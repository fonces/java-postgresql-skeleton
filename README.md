# Java PostgreSQL Skeleton

VSCodeのDev Containerを用いたSpring BootとPostgreSQLのコンテナ環境

## 概要

このプロジェクトは、Visual Studio CodeのDev Container機能を使用して、Spring BootアプリケーションとPostgreSQLデータベースを含む開発環境を提供します。

## 特徴

- **Spring Boot**: Javaベースのマイクロサービス開発フレームワーク
- **PostgreSQL**: オープンソースのリレーショナルデータベース
- **Dev Container**: VSCodeで一貫した開発環境を提供
- **Docker Compose**: 複数のコンテナを管理

## 必要な環境

- Windows 11 + WSL2
- Visual Studio Code
- Docker
- Docker Compose
- Dev Containers拡張機能

## セットアップ手順

[SETUP.md](SETUP.md)を参照

## 開発環境の構成

### Spring Bootアプリケーション
- OpenJDK 21
- Maven
- Spring Boot 4.x
- Spring Data JPA

### PostgreSQLデータベース
- PostgreSQL 15
- デフォルトデータベース: `app_db`
- ユーザー: `postgres`
- パスワード: `password`

## 使用方法

### アプリケーションの起動

```bash
./mvnw spring-boot:run
```

### データベース接続

アプリケーション内でのPostgreSQLへの接続設定は `application.yml` または `application.properties` で確認できます。

### テストの実行

```bash
./mvnw test
```

## ポート設定

- Spring Boot アプリケーション: `http://localhost:8080`
- PostgreSQL: `localhost:5432`

## 開発のヒント

- WSL2上のDockerでコンテナが実行されるため、パフォーマンスが最適化されています
- Dev Container内では、すべての依存関係が自動的にインストールされます
- PostgreSQLは別コンテナで実行され、アプリケーションコンテナから接続可能です
- VSCodeの拡張機能やデバッグ設定も自動的に設定されます
- WSL2のファイルシステム（`/home/`）にプロジェクトを配置することでパフォーマンスが向上します

## トラブルシューティング

### コンテナが起動しない場合
1. WSL2が有効になっていることを確認
2. Docker DesktopでWSL2統合が有効になっていることを確認
3. Docker Desktopが起動していることを確認
4. Dev Containers拡張機能がインストールされていることを確認
5. `.devcontainer/devcontainer.json` の設定を確認

### データベース接続エラーの場合
1. PostgreSQLコンテナが起動していることを確認
2. 接続設定（ホスト名、ポート、認証情報）を確認

### WSL2関連の問題
1. `wsl --list --verbose` でWSL2が実行されていることを確認
2. Docker DesktopのSettings > Resources > WSL Integrationで統合が有効になっていることを確認

## ライセンス

MIT License