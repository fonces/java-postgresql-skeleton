# データベース設計

## データベース名
- **app_db** - アプリケーションのメインデータベース

## テーブル構成

### users テーブル
ユーザー情報を管理するテーブル

#### カラム説明

| カラム名 | データ型 | 制約 | 説明 |
|---------|---------|------|------|
| `id` | BIGINT | PRIMARY KEY, AUTO_INCREMENT | ユーザーID（自動生成） |
| `username` | VARCHAR(50) | NOT NULL, UNIQUE | ユーザー名（3-50文字） |
| `email` | VARCHAR(255) | NOT NULL, UNIQUE | メールアドレス |
| `full_name` | VARCHAR(100) | NULL | フルネーム（最大100文字） |
| `created_at` | TIMESTAMP | NOT NULL | レコード作成日時 |
| `updated_at` | TIMESTAMP | NULL | レコード更新日時 |

#### インデックス

| インデックス名 | カラム | 説明 |
|---------------|-------|------|
| `idx_users_username` | `username` | ユーザー名検索の高速化 |
| `idx_users_email` | `email` | メールアドレス検索の高速化 |
| `idx_users_created_at` | `created_at` | 作成日時での並び替え・検索の高速化 |

#### 制約
- **username**: 3文字以上50文字以下、ユニーク制約
- **email**: 有効なメールアドレス形式、ユニーク制約
- **full_name**: 最大100文字

#### 初期データ
開発環境では以下のサンプルユーザーが自動的に挿入されます：
- john_doe (john.doe@example.com) - John Doe
- jane_smith (jane.smith@example.com) - Jane Smith
- alice_johnson (alice.johnson@example.com) - Alice Johnson
- bob_brown (bob.brown@example.com) - Bob Brown
- charlie_davis (charlie.davis@example.com) - Charlie Davis

## データベース設定

### 接続情報
- **ホスト**: db
- **ポート**: 5432
- **データベース名**: app_db
- **ユーザー名**: postgres
- **パスワード**: password

### Hibernate設定
- **DDL自動生成**: `update` - テーブル構造の自動更新
- **SQL表示**: 有効（開発環境）
- **方言**: PostgreSQLDialect

## 注意事項
- テーブルは Hibernate により自動生成されます
- 初期データは `.devcontainer/init.sql` で管理されています
- 本番環境では適切なセキュリティ設定を行ってください