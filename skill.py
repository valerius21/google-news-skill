#!/usr/bin/env python3
"""
Google News RSS Feed Skill
Author: Valerius Mattfeld (valerius21)
Usage: skill.py <query> [count] [region]
Example: skill.py "legal tech" 10 US
"""

import sys
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from typing import Optional


def fetch_google_news(query: str, count: int = 5, region: str = "US") -> None:
    """Fetch and display Google News RSS feed for a given query."""
    
    if not query:
        print("Usage: google-news <query> [count] [region]")
        print("Example: google-news \"legal tech\" 10 US")
        print()
        print("Parameters:")
        print("  query   - Search term (required)")
        print("  count   - Number of results (default: 5)")
        print("  region  - Country code (default: US, e.g., DE, GB, FR)")
        sys.exit(1)
    
    # URL-encode the query (robust encoding with urllib)
    encoded_query = urllib.parse.quote(query, safe='')
    
    # Build the RSS feed URL with configurable region
    rss_url = f"https://news.google.com/rss/search?hl=en&gl={region}&ceid={region}%3Aen&q={encoded_query}"
    
    print(f"📰 Google News: \"{query}\" (Region: {region})")
    print(f"🔗 {rss_url}")
    print()
    
    try:
        # Fetch the RSS feed with proper headers
        req = urllib.request.Request(
            rss_url,
            headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}
        )
        
        with urllib.request.urlopen(req, timeout=10) as response:
            xml_content = response.read().decode('utf-8')
        
        # Parse the XML
        root = ET.fromstring(xml_content)
        
        # Extract item titles (skip the first two which are usually "query" and "Google News")
        items = root.findall('.//item')
        titles = []
        
        for item in items:
            title_elem = item.find('title')
            if title_elem is not None and title_elem.text:
                title = title_elem.text.strip()
                # Skip generic titles
                if title and title.lower() != query.lower() and title.lower() != "google news":
                    titles.append(title)
        
        # Display the results
        for i, title in enumerate(titles[:count], 1):
            print(f" {i:2d}. {title}")
        
        if not titles:
            print(" No results found.")
        
    except urllib.error.URLError as e:
        print(f" ❌ Error fetching RSS feed: {e}")
        sys.exit(1)
    except ET.ParseError as e:
        print(f" ❌ Error parsing XML: {e}")
        sys.exit(1)
    except Exception as e:
        print(f" ❌ Unexpected error: {e}")
        sys.exit(1)
    
    print()
    print(f"💡 Tip: Add this URL to your blogwatcher: {rss_url}")


def main():
    """Main entry point."""
    query = sys.argv[1] if len(sys.argv) > 1 else ""
    count = int(sys.argv[2]) if len(sys.argv) > 2 else 5
    region = sys.argv[3] if len(sys.argv) > 3 else "US"
    
    fetch_google_news(query, count, region)


if __name__ == "__main__":
    main()
