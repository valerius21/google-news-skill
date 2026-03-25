# Google News RSS Skill

A skill for fetching current Google News via RSS feeds with configurable search queries and region localization.

## Features

- Flexible search with full URL encoding support
- Region support for localized news (US, DE, GB, FR, etc.)
- Customizable number of results
- Zero-dependency Node.js implementation
- Blogwatcher ready with RSS URL output

## Installation

```bash
npx skills add valerius21/google-news-skill
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

## Technical Details

- Language: Node.js (no external dependencies)
- URL Encoding: `encodeURIComponent()` for robust encoding
- XML Parsing: Regex-based RSS item extraction
- HTTP Client: `https` module with proper User-Agent headers
- Timeout: handled by Node.js defaults

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

## License

MIT License - see LICENSE file for details.

## Author

Valerius Mattfeld (valerius21)
