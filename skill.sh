#!/bin/bash
# Google News RSS Feed Skill
# Author: Valerius Mattfeld (valerius21)
# Usage: skill.sh <query> [count] [region]
# Example: skill.sh "legal tech" 10 US

set -e

QUERY="${1:-}"
COUNT="${2:-5}"
REGION="${3:-US}"

if [ -z "$QUERY" ]; then
    echo "Usage: google-news <query> [count] [region]"
    echo "Example: google-news \"legal tech\" 10 US"
    echo ""
    echo "Parameters:"
    echo "  query   - Search term (required)"
    echo "  count   - Number of results (default: 5)"
    echo "  region  - Country code (default: US, e.g., DE, GB, FR)"
    exit 1
fi

# URL-encode the query (robust encoding with jq)
ENCODED_QUERY=$(printf '%s' "$QUERY" | jq -sRr @uri)

# Fetch the RSS feed with configurable region
RSS_URL="https://news.google.com/rss/search?hl=en&gl=${REGION}&ceid=${REGION}%3Aen&q=${ENCODED_QUERY}"

echo "📰 Google News: \"$QUERY\" (Region: ${REGION})"
echo "🔗 ${RSS_URL}"
echo ""

# Fetch and parse the RSS feed
curl -sL "$RSS_URL" | \
    grep -oP '<title>[^<]+</title>' | \
    sed 's/<title>//g; s/<\/title>//g' | \
    head -n "$COUNT" | \
    nl -w2 -s". "

echo ""
echo "💡 Tip: Add this URL to your blogwatcher: ${RSS_URL}"
