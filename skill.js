#!/usr/bin/env node
/**
 * Google News RSS Feed Skill
 * Author: Valerius Mattfeld (valerius21)
 * Usage: skill.js <query> [count] [region]
 * Example: skill.js "legal tech" 10 US
 */

const https = require("https");

function httpsGet(url, options) {
  return new Promise((resolve, reject) => {
    https
      .get(url, options, (res) => {
        if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
          httpsGet(res.headers.location, options).then(resolve, reject);
          return;
        }
        let data = "";
        res.on("data", (chunk) => (data += chunk));
        res.on("end", () => resolve(data));
      })
      .on("error", reject);
  });
}

async function fetchGoogleNews(query, count = 5, region = "US") {
  if (!query) {
    console.log("Usage: google-news <query> [count] [region]");
    console.log('Example: google-news "legal tech" 10 US');
    console.log();
    console.log("Parameters:");
    console.log("  query   - Search term (required)");
    console.log("  count   - Number of results (default: 5)");
    console.log("  region  - Country code (default: US, e.g., DE, GB, FR)");
    process.exit(1);
  }

  const encodedQuery = encodeURIComponent(query);
  const rssUrl = `https://news.google.com/rss/search?hl=en&gl=${region}&ceid=${region}%3Aen&q=${encodedQuery}`;

  console.log(`Google News: "${query}" (Region: ${region})`);
  console.log(rssUrl);
  console.log();

  const options = {
    headers: {
      "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    },
  };

  try {
    const data = await httpsGet(rssUrl, options);
    const titles = [];
    const itemRegex = /<item>[\s\S]*?<\/item>/g;
    const titleRegex = /<title><!\[CDATA\[(.*?)\]\]>|<title>(.*?)<\/title>/;

    let match;
    while ((match = itemRegex.exec(data)) !== null) {
      const titleMatch = match[0].match(titleRegex);
      if (titleMatch) {
        const title = (titleMatch[1] || titleMatch[2] || "").trim();
        if (
          title &&
          title.toLowerCase() !== query.toLowerCase() &&
          title.toLowerCase() !== "google news"
        ) {
          titles.push(title);
        }
      }
    }

    for (let i = 0; i < Math.min(titles.length, count); i++) {
      console.log(` ${String(i + 1).padStart(2)}. ${titles[i]}`);
    }

    if (titles.length === 0) {
      console.log(" No results found.");
    }

    console.log();
    console.log(`Tip: Add this URL to your blogwatcher: ${rssUrl}`);
  } catch (err) {
    console.error(` Error fetching RSS feed: ${err.message}`);
    process.exit(1);
  }
}

const query = process.argv[2] || "";
const count = parseInt(process.argv[3], 10) || 5;
const region = process.argv[4] || "US";

fetchGoogleNews(query, count, region);
