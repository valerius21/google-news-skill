# Google News RSS Skill

An OpenClaw skill for fetching current Google News via RSS feeds with configurable search queries and region localization.

## Features

- Flexible search with full URL encoding support
- Region support for localized news (US, DE, GB, FR, etc.)
- Customizable number of results
- Fast and reliable Python3 implementation
- Blogwatcher ready with RSS URL output

## Installation

### Clone the repository

```bash
git clone https://github.com/valerius21/google-news-skill.git ~/.openclaw/skills/google-news
```

### Or copy from your OpenClaw skills directory

```bash
cp -r ~/.openclaw/skills/google-news ~/.openclaw/skills/
```

## Usage

```bash
skill.sh <query> [count] [region]
```

### Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `query` | Yes | - | Search term for Google News |
| `count` | No | `5` | Number of results to display |
| `region` | No | `US` | Country code (e.g., DE, GB, FR, JP) |

### Examples

```bash
# Basic search (US region, 5 results)
skill.sh "legal tech"

# AI news with 10 results in Germany
skill.sh "artificial intelligence" 10 DE

# Special characters are properly encoded
skill.sh "legal tech & AI" 5 US

# UK tech news
skill.sh "openclaw ai agent" 5 GB

# French technology news
skill.sh "intelligence artificielle" 8 FR
```

## Output Example

```
Google News: "legal tech" (Region: US)
https://news.google.com/rss/search?hl=en&gl=US&ceid=US%3Aen&q=legal+tech

  1. How Two Litigators Spent Five Years in Stealth Building...
  2. Thomson Is Coming, TR's Own Legally-Trained LLM
  3. TECHSHOW 2026: Where The Legal Tech Family Gathers
  4. Lawyers on edge as AI-powered tools reshape the legal profession
  5. Canada: Why 89% of legal professionals are racing toward technology...

Tip: Add this URL to your blogwatcher: https://news.google.com/rss/search?hl=en&gl=US&ceid=US%3Aen&q=legal+tech
```

## Use Cases

### 1. Blogwatcher Integration

Add the RSS URL to your blogwatcher for continuous monitoring:

```bash
echo "https://news.google.com/rss/search?hl=en&gl=US&ceid=US%3Aen&q=legal+tech | Legal Tech" >> ~/.openclaw/skills/blog-watcher/feeds.txt
```

### 2. Daily News Updates

Create a cron job for daily news digests:

```bash
# Add to crontab
0 8 * * * cd ~/.openclaw/skills/google-news && ./skill.sh "your topic" 10 US >> ~/news-digest.txt
```

### 3. Multi-Region Monitoring

Compare news coverage across different countries:

```bash
for region in US DE GB FR; do
  echo "=== $region ==="
  ./skill.sh "artificial intelligence" 3 $region
  echo
done
```

## Technical Details

### Implementation

- Language: Python 3.7+
- Dependencies: None (uses only standard library)
- URL Encoding: urllib.parse.quote() for robust encoding
- XML Parsing: xml.etree.ElementTree for RSS parsing
- HTTP Client: urllib.request with proper User-Agent headers
- Timeout: 10 seconds per request

### RSS Feed URL Structure

```
https://news.google.com/rss/search?hl=en&gl={REGION}&ceid={REGION}%3Aen&q={ENCODED_QUERY}
```

| Parameter | Description |
|-----------|-------------|
| `hl` | Interface language (en) |
| `gl` | Geographic location (US, DE, GB, etc.) |
| `ceid` | Country and language ID (REGION:en) |
| `q` | URL-encoded search query |

## Contributing

Issues, pull requests, and suggestions are welcome. Feel free to:

- Report bugs
- Suggest new features
- Improve documentation
- Add tests

## License

MIT License - see LICENSE file for details.

## Author

Valerius Mattfeld (valerius21)
