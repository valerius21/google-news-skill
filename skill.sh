#!/bin/bash
# Google News RSS Feed Skill
# Usage: skill.sh <query> [count]
# Example: skill.sh "legal tech" 10

set -e

QUERY="${1:-}"
COUNT="${2:-5}"

if [ -z "$QUERY" ]; then
    echo "Usage: google-news <query> [count]"
    echo "Example: google-news \"legal tech\" 10"
    exit 1
fi

# URL-encode the query
ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /+/g')

# Fetch the RSS feed
RSS_URL="https://news.google.com/rss/search?hl=de&gl=DE&ceid=DE%3Ade&q=${ENCODED_QUERY}"

echo "📰 Google News: \"$QUERY\""
echo "🔗 ${RSS_URL}"
echo ""

# Fetch and parse the RSS feed
curl -s "$RSS_URL" | \
    grep -oP '<title>[^<]+</title>' | \
    sed 's/<title>//g; s/<\/title>//g' | \
    head -n "$COUNT" | \
    nl -w2 -s". "

echo ""
echo "💡 Tip: Use this URL in your blogwatcher: ${RSS_URL}"
