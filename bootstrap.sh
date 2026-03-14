#!/usr/bin/env bash
# ============================================================
# bootstrap.sh — One-time setup for highzmash.com
# Run this ONCE on a fresh clone to initialize the PaperMod
# theme submodule and verify everything is in order.
# ============================================================

set -e

echo "→ Initializing PaperMod theme submodule..."
git submodule update --init --recursive

echo "→ Checking Hugo version..."
hugo version

echo "→ Verifying site builds cleanly..."
hugo --gc --minify --baseURL "http://localhost/"

echo ""
echo "✓ Setup complete!"
echo ""
echo "Run 'hugo server -D' to start local development."
echo "Push to main to trigger automatic deployment."
