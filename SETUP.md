# セットアップガイド

このドキュメントでは、WSL2環境でのDev Container開発環境のセットアップ手順を説明します。

## 目次

1. [WSL2のインストールと設定](#1-wsl2のインストールと設定)
2. [VSCode Remote Development拡張機能のインストール](#2-vscode-remote-development拡張機能のインストール)
3. [WSL上でのDockerとDocker Composeのインストール](#3-wsl上でのdockerとdocker-composeのインストール)
4. [WSL上でのGitのインストールと設定](#4-wsl上でのgitのインストールと設定)
5. [VSCodeでDev Containerの起動確認](#5-vscodeでdev-containerの起動確認)

## 1. WSL2のインストールと設定

### 1.1 Windows機能の有効化

Windows 10 (バージョン 2004以降) または Windows 11 が必要です。

1. **PowerShellを管理者権限で開きます**

2. **WSL機能を有効化します**
   ```powershell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```

3. **コンピューターを再起動します**

### 1.2 WSL2のインストール

1. **WSL2を既定バージョンに設定します**
   ```powershell
   wsl --set-default-version 2
   ```

2. **Ubuntu 22.04 LTSをインストールします**
   ```powershell
   wsl --install -d Ubuntu-22.04
   ```
   
   または、Microsoft Storeから「Ubuntu 22.04.3 LTS」をインストールすることも可能です。

3. **インストール完了後、Ubuntuを起動してユーザー設定を行います**
   - ユーザー名とパスワードを設定
   - 設定が完了したら一度ターミナルを閉じる

### 1.3 WSL2の確認

```powershell
wsl --list --verbose
```

出力例：
```
  NAME            STATE           VERSION
* Ubuntu-22.04    Running         2
```

`VERSION`が`2`になっていることを確認してください。

### 1.4 WSL2の更新

```powershell
wsl --update
```

## 2. VSCode Remote Development拡張機能のインストール

### 2.1 Visual Studio Codeのインストール

1. [VSCode公式サイト](https://code.visualstudio.com/)からダウンロード
2. インストーラーを実行してインストール

### 2.2 Remote Development拡張機能のインストール

1. **VSCodeを起動します**

2. **拡張機能ビュー（Ctrl+Shift+X）を開きます**

3. **以下の拡張機能をインストールします**

   **Remote Development（推奨）**
   - 拡張機能ID: `ms-vscode-remote.vscode-remote-extensionpack`
   - この拡張機能パックには以下が含まれます：
     - Remote - WSL
     - Remote - SSH  
     - Dev Containers

   **または個別にインストール**
   - Remote - WSL: `ms-vscode-remote.remote-wsl`
   - Dev Containers: `ms-vscode-remote.remote-containers`

### 2.3 WSL拡張機能の動作確認

1. **VSCodeでコマンドパレット（Ctrl+Shift+P）を開きます**
2. **「WSL: Connect to WSL」と入力して実行します**
3. **新しいVSCodeウィンドウが開き、左下に「WSL: Ubuntu-22.04」と表示されることを確認します**

## 3. WSL上でのDockerとDocker Composeのインストール

### 3.1 WSL2でのUbuntuを起動

```bash
wsl
```

### 3.2 システムの更新

```bash
sudo apt update && sudo apt upgrade -y
```

### 3.3 必要なパッケージのインストール

```bash
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common
```

### 3.4 DockerのGPGキーを追加

```bash
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### 3.5 Dockerリポジトリを追加

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 3.6 パッケージリストを更新

```bash
sudo apt update
```

### 3.7 Docker Engineのインストール

```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 3.8 現在のユーザーをdockerグループに追加

```bash
sudo usermod -aG docker $USER
```

### 3.9 WSLを再起動（重要）

**PowerShellで以下を実行します：**
```powershell
wsl --shutdown
```

その後、WSLを再度起動します：
```powershell
wsl
```

### 3.10 Dockerの動作確認

```bash
# Dockerサービスの状態確認
sudo systemctl status docker

# Dockerサービスの開始（必要に応じて）
sudo systemctl start docker

# Hello Worldコンテナの実行テスト
docker run hello-world
```

### 3.11 Docker Composeの動作確認

```bash
docker compose version
```

出力例：
```
Docker Compose version v2.21.0
```

## 4. WSL上でのGitのインストールと設定

### 4.1 Gitのインストール

```bash
sudo apt install -y git
```

### 4.2 Gitの動作確認

```bash
git --version
```

出力例：
```
git version 2.34.1
```

### 4.3 Gitの基本設定

```bash
# ユーザー名を設定（GitHubのユーザー名を推奨）
git config --global user.name "あなたの名前"

# メールアドレスを設定（GitHubで使用しているメールアドレス）
git config --global user.email "your.email@example.com"

# デフォルトブランチ名をmainに設定（推奨）
git config --global init.defaultBranch main

# 改行コードの設定（Windowsとの互換性のため）
git config --global core.autocrlf input

# 日本語ファイル名の文字化け防止
git config --global core.quotepath false
```

### 4.4 設定の確認

```bash
git config --list --global
```

### 4.5 SSH鍵の設定（GitHubを使用する場合）

**SSH鍵を生成:**
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

**SSH鍵をssh-agentに追加:**
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**公開鍵を表示（GitHubに登録用）:**
```bash
cat ~/.ssh/id_ed25519.pub
```

**GitHubでの設定手順:**
1. GitHub > Settings > SSH and GPG keys
2. "New SSH key"をクリック
3. 表示された公開鍵をコピーして貼り付け
4. "Add SSH key"をクリック

**SSH接続テスト:**
```bash
ssh -T git@github.com
```

成功時の出力例：
```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

## 5. VSCodeでDev Containerの起動確認

### 5.1 プロジェクトのクローン

WSL2のUbuntuターミナルで：

```bash
# ホームディレクトリに移動
cd ~

# gitディレクトリを作成（存在しない場合）
mkdir -p git
cd git

# リポジトリをクローン
git clone https://github.com/fonces/java-postgresql-skeleton.git
cd java-postgresql-skeleton
```

### 5.2 VSCodeでプロジェクトを開く

```bash
code .
```

### 5.3 Dev Containerの起動

1. **VSCodeでコマンドパレット（Ctrl+Shift+P）を開きます**

2. **「Dev Containers: Reopen in Container」と入力して実行します**

3. **初回起動時の処理**
   - Dockerイメージのプル（数分かかる場合があります）
   - コンテナの構築
   - 必要な拡張機能のインストール
   - Java環境のセットアップ

4. **起動完了の確認**
   - 左下のステータスバーに「Dev Container: Java PostgreSQL Development」と表示される
   - ターミナルで以下のコマンドが実行できることを確認：
     ```bash
     java --version
     ./mvnw --version
     docker ps
     ```

### 5.4 アプリケーションの動作確認

1. **Spring Bootアプリケーションを起動**
   ```bash
   ./mvnw spring-boot:run
   ```

2. **ブラウザでアクセス確認**
   - `http://localhost:8080/api/users` にアクセス
   - JSON形式でユーザー一覧が表示されることを確認

3. **PostgreSQLの接続確認**
   ```bash
   # PostgreSQLコンテナに接続
   docker exec -it $(docker ps -q -f name=db) psql -U postgres -d app_db
   
   # テーブル確認
   \dt
   
   # サンプルデータ確認  
   SELECT * FROM users;
   
   # 終了
   \q
   ```

## トラブルシューティング

### WSL2関連

**問題**: WSL2が起動しない
- **解決**: BIOSで仮想化機能（VT-x/AMD-V）が有効になっていることを確認

**問題**: `wsl --install`が失敗する
- **解決**: Windows Updateを実行してから再実行

### Docker関連

**問題**: `docker: permission denied`
- **解決**: ユーザーがdockerグループに追加されているか確認し、WSLを再起動

**問題**: Docker Composeが見つからない
- **解決**: `docker compose`（ハイフンなし）で実行、または`sudo apt install docker-compose`

### Dev Container関連

**問題**: Dev Containerが起動しない
- **解決**: 
  1. Docker Desktopが起動していることを確認
  2. WSL Integration設定を確認
  3. `.devcontainer/devcontainer.json`の構文エラーを確認

**問題**: 拡張機能がインストールされない
- **解決**: インターネット接続を確認し、VSCodeを再起動

## 参考リンク

- [WSL2公式ドキュメント](https://docs.microsoft.com/ja-jp/windows/wsl/)
- [Docker公式インストールガイド（Ubuntu）](https://docs.docker.com/engine/install/ubuntu/)
- [VSCode Dev Containers公式ドキュメント](https://code.visualstudio.com/docs/devcontainers/containers)
- [Remote Development拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)