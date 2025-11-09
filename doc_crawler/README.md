# Crawl4AI Documentation Extractor

A powerful, production-ready tool for extracting documentation from any website using [Crawl4AI](https://github.com/unclecode/crawl4ai) - the leading LLM-friendly web crawler with 54.9k+ stars.

## 🚀 Why Crawl4AI?

- ✅ **54.9k stars** - Highly popular and well-maintained
- ✅ **LLM-friendly** - Specifically designed for AI/LLM data extraction
- ✅ **JavaScript support** - Handles dynamic content better than basic crawlers
- ✅ **Advanced extraction** - Multiple strategies (LLM, cosine, regex)
- ✅ **Production ready** - Used by 2.6k+ projects
- ✅ **Active community** - Regular updates and support
- ✅ **Schema generation** - Converts natural language to extraction schemas
- ✅ **Semantic search** - Built-in web embedding index

## 📦 Installation

### 1. Install Crawl4AI
```bash
pip install crawl4ai
```

### 2. Install Playwright Browsers
```bash
playwright install chromium
```

## 🎯 Quick Start

### Basic Usage
```bash
# Windows
doc_crawler.bat https://docs.stac.dev

# Unix/Linux/Mac
python doc_crawler.py https://docs.stac.dev
```

### Advanced Usage
```bash
# Extract with limits and screenshots
python doc_crawler.py https://docs.stac.dev --max-pages 50 --screenshot

# Custom output directory
python doc_crawler.py https://docs.stac.dev --output my_docs

# High-performance crawling
python doc_crawler.py https://docs.stac.dev --delay 0.5 --timeout 60
```

## 🔧 Command Line Options

- `--max-pages N` - Maximum number of pages to crawl
- `--output DIR` - Output directory name
- `--delay SECONDS` - Delay between requests (default: 1.0)
- `--timeout SECONDS` - Request timeout (default: 30)
- `--js-wait SECONDS` - Wait time for JavaScript (default: 2)
- `--screenshot` - Take screenshots of pages

## 📊 Output Structure

After crawling, you'll get:

```
{domain}_crawl4ai_extracted/
├── README.md                    # Index with success/failure status
├── complete_docs.json          # All data in JSON format
├── searchable_index.json       # Searchable keyword index
├── index.md                    # Main page
├── page1.md                    # Individual pages
├── page2.md
└── ...
```

### Enhanced JSON Output
```json
{
  "https://docs.example.com/page1": {
    "url": "https://docs.example.com/page1",
    "title": "Page Title",
    "content": "Raw HTML content",
    "markdown": "Clean markdown content",
    "extracted_content": {
      "structured_data": "LLM-extracted structured data"
    },
    "links": ["https://docs.example.com/link1"],
    "images": ["https://docs.example.com/image1.png"],
    "extracted_at": "2025-10-22 14:50:19",
    "success": true
  }
}
```

## 🎯 Use Cases

### For AI Agents
- **Better Content Extraction** - Crawl4AI's LLM integration provides cleaner, more structured content
- **JavaScript Support** - Handles modern documentation sites with dynamic content
- **Schema Extraction** - Automatically structures content for AI consumption

### For Documentation Teams
- **Comprehensive Extraction** - Better handling of complex documentation structures
- **Quality Assurance** - Built-in success/failure tracking
- **Visual Verification** - Screenshot capability for quality checks

## 🚀 Examples

### Extract Stac Documentation
```bash
python doc_crawler.py https://docs.stac.dev
```

### Extract Flutter Documentation
```bash
python doc_crawler.py https://docs.flutter.dev --max-pages 100
```

### Extract React Documentation with Screenshots
```bash
python doc_crawler.py https://react.dev --screenshot --output react_docs
```

## 🔍 Troubleshooting

### Common Issues

1. **Installation Issues**
   ```bash
   # Install Playwright browsers
   playwright install chromium
   
   # Install additional dependencies
   pip install playwright openai
   ```

2. **JavaScript Content Not Loading**
   - Increase `--js-wait` parameter
   - Check if the site requires authentication
   - Verify the site doesn't block automated access

3. **Memory Issues**
   - Reduce `--max-pages`
   - Use `--delay` to slow down requests
   - Monitor system resources

## 📈 Performance Tips

1. **Start Small** - Test with `--max-pages 10` first
2. **Use Appropriate Delays** - Respect server resources
3. **Monitor Success Rate** - Check the README.md for extraction success
4. **Use Screenshots** - For debugging and quality assurance
5. **Batch Processing** - For large sites, consider running in batches

## 🎉 Success Metrics

After successful crawling, you should see:
- ✅ High success rate in README.md
- ✅ Clean markdown content in individual files
- ✅ Structured JSON data with extracted content
- ✅ Screenshots (if enabled) for visual verification
- ✅ Comprehensive searchable index

## 🔮 Advanced Features

### LLM Extraction (Optional)
For even better content extraction, you can configure LLM integration:

```python
# In doc_crawler.py, you can modify the extraction strategy
extraction_strategy = LLMExtractionStrategy(
    provider="ollama/llama3.1",  # or "openai/gpt-4"
    api_token="your-api-token",
    instruction="Extract the main documentation content, code examples, and structure"
)
```

### Custom Configuration
You can modify the crawler behavior by editing the configuration in `doc_crawler.py`:

```python
config = {
    'max_pages': 100,
    'delay_between_requests': 1,
    'timeout': 30,
    'js_wait': 2,
    'screenshot': True,
    'extraction_strategy': 'llm',  # 'llm', 'cosine', 'regex'
    'follow_external_links': False
}
```

## 📚 Documentation

- **Crawl4AI Guide**: See `CRAWL4AI_GUIDE.md` for detailed instructions
- **Crawl4AI Repository**: https://github.com/unclecode/crawl4ai
- **Crawl4AI Documentation**: https://crawl4ai.com

## 🤝 Contributing

This tool is built on top of the excellent [Crawl4AI](https://github.com/unclecode/crawl4ai) library. 

- **Crawl4AI GitHub**: https://github.com/unclecode/crawl4ai
- **Crawl4AI Discord**: https://discord.gg/jP8KfhDhyN

## 📄 License

This project uses Crawl4AI, which is licensed under the Apache License 2.0.

---

**Happy crawling! 🚀**

This tool provides the most advanced, production-ready solution for extracting documentation for AI agents and offline access.