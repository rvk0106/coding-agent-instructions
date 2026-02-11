#!/usr/bin/env bash
# Quick install script for agent-instructions-rails-api
# Usage: curl -fsSL https://raw.githubusercontent.com/rvk0106/coding-agent-instructions/main/agent-instructions-rails-api/quick-install.sh | bash
# Or with custom directory: curl ... | bash -s /path/to/rails/project

set -euo pipefail

REPO_URL="https://github.com/rvk0106/coding-agent-instructions"
FRAMEWORK_DIR="agent-instructions-rails-api"
BRANCH="main"
TEMP_DIR=$(mktemp -d)
TARGET_DIR="${1:-.}"

echo "🚀 Installing agent-instructions-rails-api..."
echo "📂 Target directory: $(cd "$TARGET_DIR" && pwd)"
echo ""

# Check if target is a directory
if [[ ! -d "$TARGET_DIR" ]]; then
  echo "❌ Error: Target directory does not exist: $TARGET_DIR"
  exit 1
fi

# Check if it looks like a Rails project
if [[ ! -f "$TARGET_DIR/Gemfile" ]] && [[ ! -f "$TARGET_DIR/config/application.rb" ]]; then
  echo "⚠️  Warning: This doesn't look like a Rails project."
  if [[ -t 0 ]]; then
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Installation cancelled."
      exit 0
    fi
  else
    echo "Non-interactive mode (piped install). Continuing anyway..."
  fi
fi

# Download the repository
echo "📥 Downloading from GitHub..."
if command -v git &> /dev/null; then
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR" 2>/dev/null
else
  echo "📦 Git not found, using curl..."
  curl -fsSL "$REPO_URL/archive/refs/heads/$BRANCH.tar.gz" | tar -xz -C "$TEMP_DIR" --strip-components=1
fi

# Run the installer
echo "⚙️  Running installer..."
cd "$TEMP_DIR/$FRAMEWORK_DIR"
chmod +x install.sh
bash install.sh "$TARGET_DIR"

# Clean up
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo ""
echo "✅ Installation complete!"
echo ""
echo "📚 Documentation: $REPO_URL"
echo "🐛 Issues: $REPO_URL/issues"
echo ""
echo "Next steps:"
echo "1. Configure ticketing (pick one):"
echo "   - Linear:  export LINEAR_API_TOKEN=\"your_token\""
echo "   - Jira:    export JIRA_API_TOKEN=\"your_token\" JIRA_URL=\"https://your-domain.atlassian.net\""
echo "   - GitHub:  export GITHUB_TOKEN=\"your_token\" GITHUB_REPO=\"owner/repo\""
echo "   - Manual:  create tickets in tickets/TICKET-ID.md (no setup needed)"
echo "2. Plan a ticket: plan architecture for TICKET-ID"
echo "3. Execute: execute plan 1 for TICKET-ID"
echo ""
