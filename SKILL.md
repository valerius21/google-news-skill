# Google News RSS

Fetch current Google News via RSS feeds for any search query with configurable region localization.

## Author

Valerius Mattfeld (valerius21)

## Usage

```bash
skill.sh <query> [count] [region]
```

## Parameters

- `query` (required): Search term for Google News
- `count` (optional): Number of results (Default: 5)
- `region` (optional): Country code for localization (Default: US)
  - Examples: `US`, `DE`, `GB`, `FR`, `JP`, etc.

## Examples

```bash
# Legal Tech news (US region, default)
skill.sh "legal tech"

# AI news with 10 results in Germany
skill.sh "artificial intelligence" 10 DE

# Special characters are properly encoded
skill.sh "legal tech & AI" 5 US

# Specific search in UK
skill.sh "openclaw ai agent" 5 GB

# French tech news
skill.sh "technologie" 8 FR
```

## RSS Feed URL

The skill uses the following URL structure:
```
https://news.google.com/rss/search?hl=en&gl=${REGION}&ceid=${REGION}%3Aen&q=${urlencoded_query}
```

## Use Cases

- **Blogwatcher:** Add news feeds to your blogwatcher for continuous monitoring
- **Daily Updates:** Get current news on specific topics
- **Research:** Quick overview of latest developments
- **Multi-region monitoring:** Compare news coverage across different countries

## Output

The skill outputs a numbered list of the latest article titles and displays the RSS URL for further use in blogwatcher or other RSS readers.

## Implementation

Written in Python 3 with:
- `urllib.parse.quote()` for robust URL encoding
- `xml.etree.ElementTree` for XML parsing
- `urllib.request` for HTTP requests with proper headers
