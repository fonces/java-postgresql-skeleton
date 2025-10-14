-- Initialize database
\c app_db;

-- Create users table (will be created automatically by Hibernate, but we can add initial data)
-- This file is for initial data insertion only

-- Insert sample data
INSERT INTO users (username, email, full_name, created_at, updated_at) VALUES
('john_doe', 'john.doe@example.com', 'John Doe', NOW(), NOW()),
('jane_smith', 'jane.smith@example.com', 'Jane Smith', NOW(), NOW()),
('alice_johnson', 'alice.johnson@example.com', 'Alice Johnson', NOW(), NOW()),
('bob_brown', 'bob.brown@example.com', 'Bob Brown', NOW(), NOW()),
('charlie_davis', 'charlie.davis@example.com', 'Charlie Davis', NOW(), NOW())
ON CONFLICT (username) DO NOTHING;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON users(created_at);