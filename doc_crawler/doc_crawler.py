#!/usr/bin/env python3
"""
Crawl4AI Integration for Documentation Extraction - Windows Fixed Version
Uses the powerful Crawl4AI library for better documentation crawling
"""

import asyncio
import json
import os
import sys
import tempfile
from datetime import datetime
from typing import Dict, List, Optional
import argparse

# Set environment variables for Windows console encoding
os.environ['PYTHONIOENCODING'] = 'utf-8'
os.environ['PYTHONLEGACYWINDOWSSTDIO'] = '1'

try:
    from crawl4ai import AsyncWebCrawler
    from crawl4ai.extraction_strategy import LLMExtractionStrategy
    from crawl4ai.chunking_strategy import RegexChunking
    CRAWL4AI_AVAILABLE = True
except ImportError:
    CRAWL4AI_AVAILABLE = False
    print("Crawl4AI not installed. Install with: pip install crawl4ai")

class Crawl4AIDocExtractor:
    def __init__(self, base_url: str, config: Dict = None):
        self.base_url = base_url
        self.config = config or self.get_default_config()
        self.extracted_content = {}
        
    def get_default_config(self) -> Dict:
        """Get default configuration for Crawl4AI"""
        return {
            'max_pages': 50,  # Increased to capture more documentation pages
            'delay_between_requests': 1,
            'timeout': 30,
            'follow_external_links': False,
            'extraction_strategy': 'regex',  # Use regex instead of LLM to avoid API issues
            'chunking_strategy': 'regex',
            'js_wait': 2,  # Wait for JavaScript to load
            'screenshot': False,
            'output_formats': {
                'markdown': True,
                'json': True,
                'individual_files': True,
                'searchable_index': True
            }
        }
    
    async def extract_single_page(self, crawler: AsyncWebCrawler, url: str) -> Dict:
        """Extract content from a single page using Crawl4AI"""
        try:
            print(f"Extracting: {url}")
            
            # Crawl the page with minimal configuration
            result = await crawler.arun(
                url=url,
                word_count_threshold=10,
                chunking_strategy=RegexChunking(),
                js_code=[
                    "window.scrollTo(0, document.body.scrollHeight);",
                    "await new Promise(resolve => setTimeout(resolve, 2000));"
                ],
                wait_for="css:main, article, .content, .documentation",
                screenshot=self.config.get('screenshot', False)
            )
            
            if result.success:
                return {
                    'url': url,
                    'title': result.metadata.get('title', 'Untitled'),
                    'content': result.cleaned_html or result.html,
                    'markdown': result.markdown,
                    'extracted_content': result.extracted_content,
                    'links': [link.get('href', '') for link in result.links if isinstance(link, dict) and link.get('href')],
                    'images': [img.get('src', '') for img in result.media if isinstance(img, dict) and img.get('type') == 'image'],
                    'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                    'success': True
                }
            else:
                return {
                    'url': url,
                    'title': 'Error',
                    'content': f'Failed to extract: {result.error_message}',
                    'markdown': '',
                    'extracted_content': {},
                    'links': [],
                    'images': [],
                    'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                    'success': False
                }
                
        except Exception as e:
            return {
                'url': url,
                'title': 'Error',
                'content': f'Exception during extraction: {str(e)}',
                'markdown': '',
                'extracted_content': {},
                'links': [],
                'images': [],
                'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                'success': False
            }
    
    async def crawl_documentation(self) -> Dict[str, Dict]:
        """Crawl all documentation pages using Crawl4AI"""
        if not CRAWL4AI_AVAILABLE:
            raise ImportError("Crawl4AI is not installed. Install with: pip install crawl4ai")
        
        print(f"Starting Crawl4AI documentation crawl for {self.base_url}...")
        
        # Create a temporary log file to redirect output
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.log') as log_file:
            log_path = log_file.name
        
        # Redirect stdout and stderr to avoid encoding issues
        original_stdout = sys.stdout
        original_stderr = sys.stderr
        
        try:
            # Redirect output to file to avoid console encoding issues
            with open(log_path, 'w', encoding='utf-8') as log_file:
                sys.stdout = log_file
                sys.stderr = log_file
                
                # Initialize crawler with minimal settings
                async with AsyncWebCrawler(
                    headless=True,
                    browser_type="chromium",
                    verbose=False  # Disable verbose to avoid encoding issues
                ) as crawler:
                    
                    # Start with base URL
                    urls_to_visit = {self.base_url}
                    visited_urls = set()
                    max_pages = self.config.get('max_pages')
                    page_count = 0
                    
                    while urls_to_visit:
                        current_url = urls_to_visit.pop()
                        
                        if current_url in visited_urls:
                            continue
                        
                        if max_pages and page_count >= max_pages:
                            print(f"Reached maximum pages limit: {max_pages}")
                            break
                        
                        visited_urls.add(current_url)
                        page_count += 1
                        
                        # Extract content
                        content = await self.extract_single_page(crawler, current_url)
                        self.extracted_content[current_url] = content
                        
                        # Find new links to visit
                        if content.get('success', False):
                            new_links = content.get('links', [])
                            for link in new_links:
                                # Convert relative URLs to absolute URLs
                                if link.startswith('/'):
                                    full_link = f"{self.base_url.rstrip('/')}{link}"
                                elif link.startswith('http'):
                                    full_link = link
                                else:
                                    continue
                                
                                # Only follow internal documentation links
                                if (full_link not in visited_urls and 
                                    full_link.startswith(self.base_url) and
                                    '/docs/' in full_link and
                                    not any(ext in full_link.lower() for ext in ['.pdf', '.jpg', '.png', '.gif', '.css', '.js', '.svg', '.ico'])):
                                    urls_to_visit.add(full_link)
                        
                        # Be respectful
                        await asyncio.sleep(self.config.get('delay_between_requests', 1))
                        
                        print(f"Progress: {len(visited_urls)} pages visited, {len(urls_to_visit)} remaining")
                    
                    print(f"Crawl completed. Total pages: {len(self.extracted_content)}")
                    
        finally:
            # Restore stdout and stderr
            sys.stdout = original_stdout
            sys.stderr = original_stderr
            
            # Clean up log file
            if os.path.exists(log_path):
                os.unlink(log_path)
        
        return self.extracted_content
    
    def save_to_files(self, output_dir: str = None):
        """Save extracted content to files"""
        if not output_dir:
            from urllib.parse import urlparse
            domain_name = urlparse(self.base_url).netloc.replace('.', '_')
            output_dir = f"{domain_name}_crawl4ai_extracted"
        
        os.makedirs(output_dir, exist_ok=True)
        
        # Save complete JSON
        if self.config.get('output_formats', {}).get('json', True):
            with open(os.path.join(output_dir, 'complete_docs.json'), 'w', encoding='utf-8') as f:
                json.dump(self.extracted_content, f, indent=2, ensure_ascii=False)
        
        # Save individual markdown files
        if self.config.get('output_formats', {}).get('individual_files', True):
            for url, content in self.extracted_content.items():
                filename = self.create_filename(url)
                
                # Use markdown content if available, otherwise use HTML
                markdown_content = content.get('markdown', content.get('content', ''))
                
                # Create enhanced markdown
                enhanced_md = self.create_enhanced_markdown(content, markdown_content)
                
                with open(os.path.join(output_dir, filename), 'w', encoding='utf-8') as f:
                    f.write(enhanced_md)
        
        # Create index file
        self.create_index_file(output_dir)
        
        # Create searchable index
        if self.config.get('output_formats', {}).get('searchable_index', True):
            self.create_searchable_index(output_dir)
        
        print(f"Content saved to {output_dir}/")
        return output_dir
    
    def create_filename(self, url: str) -> str:
        """Create filename from URL"""
        import re
        filename = url.replace(self.base_url, '').strip('/')
        if not filename:
            filename = 'index'
        filename = re.sub(r'[^\w\-_\.]', '_', filename)
        if not filename.endswith('.md'):
            filename += '.md'
        return filename
    
    def create_enhanced_markdown(self, content: Dict, markdown_content: str) -> str:
        """Create enhanced markdown content"""
        md = f"""# {content.get('title', 'Untitled')}

**URL:** {content.get('url', '')}  
**Extracted:** {content.get('extracted_at', '')}  
**Success:** {content.get('success', False)}

## Content

{markdown_content}

"""
        
        # Add extracted content if available
        if content.get('extracted_content'):
            md += "\n## Extracted Data\n\n"
            md += f"```json\n{json.dumps(content['extracted_content'], indent=2)}\n```\n\n"
        
        # Add links
        if content.get('links'):
            md += "\n## Links\n\n"
            for link in content['links'][:20]:  # Limit to first 20 links
                md += f"- {link}\n"
        
        # Add images
        if content.get('images'):
            md += "\n## Images\n\n"
            for img in content['images'][:10]:  # Limit to first 10 images
                md += f"![Image]({img})\n"
        
        return md
    
    def create_index_file(self, output_dir: str):
        """Create an index file"""
        index_content = f"""# Crawl4AI Documentation Index

This directory contains documentation extracted using Crawl4AI from {self.base_url}

## Pages

"""
        
        for url, content in self.extracted_content.items():
            filename = self.create_filename(url)
            success_status = "✅" if content.get('success', False) else "❌"
            index_content += f"- {success_status} [{content.get('title', 'Untitled')}]({filename}) - {url}\n"
        
        index_content += f"""

## Summary

- **Total pages extracted:** {len(self.extracted_content)}
- **Successful extractions:** {sum(1 for c in self.extracted_content.values() if c.get('success', False))}
- **Failed extractions:** {sum(1 for c in self.extracted_content.values() if not c.get('success', False))}
- **Extraction completed:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
- **Base URL:** {self.base_url}
- **Tool:** Crawl4AI

"""
        
        with open(os.path.join(output_dir, 'README.md'), 'w', encoding='utf-8') as f:
            f.write(index_content)
    
    def create_searchable_index(self, output_dir: str):
        """Create a searchable index"""
        searchable_index = {
            'base_url': self.base_url,
            'tool': 'Crawl4AI',
            'pages': [],
            'keywords': {},
            'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        }
        
        for url, content in self.extracted_content.items():
            if content.get('success', False):
                page_info = {
                    'url': url,
                    'title': content.get('title', 'Untitled'),
                    'filename': self.create_filename(url),
                    'success': content.get('success', False),
                    'content_length': len(content.get('markdown', '')),
                    'has_extracted_content': bool(content.get('extracted_content'))
                }
                searchable_index['pages'].append(page_info)
        
        with open(os.path.join(output_dir, 'searchable_index.json'), 'w', encoding='utf-8') as f:
            json.dump(searchable_index, f, indent=2, ensure_ascii=False)

async def main():
    """Main function"""
    parser = argparse.ArgumentParser(description='Crawl4AI Documentation Extractor')
    parser.add_argument('url', help='Base URL to crawl')
    parser.add_argument('--max-pages', type=int, help='Maximum number of pages to crawl')
    parser.add_argument('--output', help='Output directory name')
    parser.add_argument('--delay', type=float, default=1.0, help='Delay between requests (seconds)')
    parser.add_argument('--timeout', type=int, default=30, help='Request timeout (seconds)')
    parser.add_argument('--js-wait', type=int, default=2, help='Wait time for JavaScript (seconds)')
    parser.add_argument('--screenshot', action='store_true', help='Take screenshots')
    
    args = parser.parse_args()
    
    if not CRAWL4AI_AVAILABLE:
        print("❌ Crawl4AI is not installed!")
        print("Install it with: pip install crawl4ai")
        print("For more info: https://github.com/unclecode/crawl4ai")
        return
    
    # Create configuration
    config = {
        'max_pages': args.max_pages,
        'delay_between_requests': args.delay,
        'timeout': args.timeout,
        'js_wait': args.js_wait,
        'screenshot': args.screenshot
    }
    
    # Create extractor
    extractor = Crawl4AIDocExtractor(args.url, config)
    
    print("Crawl4AI Documentation Extractor")
    print("=" * 40)
    print(f"Target URL: {args.url}")
    print(f"Max pages: {args.max_pages or 'unlimited'}")
    print(f"Delay: {args.delay}s")
    print(f"Timeout: {args.timeout}s")
    print(f"JS Wait: {args.js_wait}s")
    print(f"Screenshots: {'Yes' if args.screenshot else 'No'}")
    print()
    
    try:
        # Crawl documentation
        extracted_content = await extractor.crawl_documentation()
        
        # Save to files
        output_dir = extractor.save_to_files(args.output)
        
        print("\nExtraction completed!")
        print(f"Total pages extracted: {len(extracted_content)}")
        successful = sum(1 for c in extracted_content.values() if c.get('success', False))
        print(f"Successful extractions: {successful}")
        print(f"Failed extractions: {len(extracted_content) - successful}")
        print(f"Files saved to: {output_dir}/")
        print(f"Main file: {output_dir}/complete_docs.json")
        print(f"Index file: {output_dir}/README.md")
        
    except Exception as e:
        print(f"\nError during crawling: {str(e)}")

if __name__ == "__main__":
    asyncio.run(main())
