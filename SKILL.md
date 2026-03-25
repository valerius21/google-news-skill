# Google News RSS

Abruf aktueller Google News über RSS-Feeds für beliebige Suchbegriffe.

## Usage

```bash
skill.sh <query> [count]
```

## Parameters

- `query` (required): Suchbegriff für Google News
- `count` (optional): Anzahl der Ergebnisse (Default: 5)

## Examples

```bash
# Legal Tech Nachrichten
skill.sh "legal tech"

# KI Nachrichten mit 10 Ergebnissen
skill.sh "künstliche intelligenz" 10

# Spezifische Suche
skill.sh "openclaw ai agent" 5
```

## RSS Feed URL

Der Skill nutzt folgende URL-Struktur:
```
https://news.google.com/rss/search?hl=de&gl=DE&ceid=DE%3Ade&q=${urlencoded_query}
```

## Use Cases

- **Blogwatcher:** Füge News-Feeds zu deinem blogwatcher hinzu
- **Tägliche Updates:** Erhalte aktuelle Nachrichten zu spezifischen Themen
- **Research:** Schneller Überblick zu aktuellen Entwicklungen

## Output

Die Skill gibt eine nummerierte Liste der neuesten Artikel-Titel aus und zeigt die verwendete RSS-URL für weitere Verwendung.
