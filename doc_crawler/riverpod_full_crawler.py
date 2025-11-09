#!/usr/bin/env python3
"""
Complete Riverpod Documentation Crawler
Crawls all major Riverpod documentation pages
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
    from crawl4ai.chunking_strategy import RegexChunking
    CRAWL4AI_AVAILABLE = True
except ImportError:
    CRAWL4AI_AVAILABLE = False
    print("Crawl4AI not installed. Install with: pip install crawl4ai")

class RiverpodFullCrawler:
    def __init__(self, base_url: str = "https://riverpod.dev"):
        self.base_url = base_url
        self.extracted_content = {}
        
        # Pre-defined list of major Riverpod documentation pages
        self.documentation_urls = [
            # Getting Started
            "https://riverpod.dev/docs/introduction/getting_started",
            
            # What's New & Migration
            "https://riverpod.dev/docs/whats_new",
            "https://riverpod.dev/docs/3.0_migration",
            
            # FAQ & Guidelines
            "https://riverpod.dev/docs/root/faq",
            "https://riverpod.dev/docs/root/do_dont",
            
            # Tutorials
            "https://riverpod.dev/docs/tutorials/first_app",
            
            # Core Concepts
            "https://riverpod.dev/docs/concepts2/providers",
            "https://riverpod.dev/docs/concepts2/consumers",
            "https://riverpod.dev/docs/concepts2/containers",
            "https://riverpod.dev/docs/concepts2/refs",
            "https://riverpod.dev/docs/concepts2/auto_dispose",
            "https://riverpod.dev/docs/concepts2/family",
            "https://riverpod.dev/docs/concepts2/mutations",
            "https://riverpod.dev/docs/concepts2/offline",
            "https://riverpod.dev/docs/concepts2/retry",
            "https://riverpod.dev/docs/concepts2/observers",
            "https://riverpod.dev/docs/concepts2/overrides",
            "https://riverpod.dev/docs/concepts2/scoping",
            "https://riverpod.dev/docs/concepts/about_code_generation",
            "https://riverpod.dev/docs/concepts/about_hooks",
            
            # How-to Guides
            "https://riverpod.dev/docs/how_to/testing",
            "https://riverpod.dev/docs/how_to/select",
            "https://riverpod.dev/docs/how_to/eager_initialization",
            "https://riverpod.dev/docs/how_to/pull_to_refresh",
            "https://riverpod.dev/docs/how_to/cancel",
            
            # Migration Guides
            "https://riverpod.dev/docs/from_provider/quickstart",
            "https://riverpod.dev/docs/migration/from_state_notifier",
            "https://riverpod.dev/docs/migration/from_change_notifier",
            "https://riverpod.dev/docs/migration/0.14.0_to_1.0.0",
            "https://riverpod.dev/docs/migration/0.13.0_to_0.14.0",
        ]
    
    async def extract_single_page(self, crawler, url: str) -> Dict:
        """Extract content from a single page"""
        try:
            print(f"Extracting: {url}")
            
            # Crawl the page
            result = await crawler.arun(
                url=url,
                word_count_threshold=10,
                chunking_strategy=RegexChunking(),
                js_code=[
                    "window.scrollTo(0, document.body.scrollHeight);",
                    "await new Promise(resolve => setTimeout(resolve, 2000));"
                ],
                wait_for="networkidle"
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
                    'title': 'Failed to extract',
                    'content': '',
                    'markdown': '',
                    'extracted_content': None,
                    'links': [],
                    'images': [],
                    'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                    'success': False
                }
        except Exception as e:
            print(f"Error extracting {url}: {e}")
            return {
                'url': url,
                'title': 'Error',
                'content': '',
                'markdown': '',
                'extracted_content': None,
                'links': [],
                'images': [],
                'extracted_at': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                'success': False
            }
    
    async def crawl_all_documentation(self, delay: float = 2.0) -> Dict:
        """Crawl all Riverpod documentation pages"""
        print(f"Starting complete Riverpod documentation crawl...")
        print(f"Total pages to crawl: {len(self.documentation_urls)}")
        
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
                
                # Initialize crawler
                async with AsyncWebCrawler(
                    headless=True,
                    browser_type="chromium",
                    verbose=False
                ) as crawler:
                    
                    for i, url in enumerate(self.documentation_urls, 1):
                        print(f"Processing page {i}/{len(self.documentation_urls)}: {url}")
                        
                        # Extract content
                        content = await self.extract_single_page(crawler, url)
                        self.extracted_content[url] = content
                        
                        # Be respectful - delay between requests
                        if i < len(self.documentation_urls):  # Don't delay after the last page
                            await asyncio.sleep(delay)
                    
                    print(f"Crawl completed. Total pages: {len(self.extracted_content)}")
                    
        finally:
            # Restore stdout and stderr
            sys.stdout = original_stdout
            sys.stderr = original_stderr
            
            # Clean up log file
            if os.path.exists(log_path):
                os.unlink(log_path)
        
        return self.extracted_content
    
    def save_results(self, output_dir: str = None):
        """Save the extracted content to files"""
        if not output_dir:
            output_dir = "riverpod_complete_docs"
        
        os.makedirs(output_dir, exist_ok=True)
        
        # Save complete JSON
        with open(os.path.join(output_dir, 'complete_docs.json'), 'w', encoding='utf-8') as f:
            json.dump(self.extracted_content, f, indent=2, ensure_ascii=False)
        
        # Save individual markdown files
        for url, content in self.extracted_content.items():
            filename = self.create_filename(url)
            filepath = os.path.join(output_dir, f"{filename}.md")
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(f"# {content.get('title', 'Untitled')}\n\n")
                f.write(f"**URL:** {url}\n\n")
                f.write(content.get('markdown', ''))
        
        # Create searchable index
        self.create_searchable_index(output_dir)
        
        # Create README
        self.create_readme(output_dir)
        
        return output_dir
    
    def create_filename(self, url: str) -> str:
        """Create a filename from URL"""
        from urllib.parse import urlparse
        path = urlparse(url).path
        if path.endswith('/'):
            path = path[:-1]
        if not path:
            return 'index'
        return path.replace('/', '_').replace('\\', '_').strip('_')
    
    def create_searchable_index(self, output_dir: str):
        """Create a searchable index of all content"""
        index = {}
        for url, content in self.extracted_content.items():
            if content.get('success', False):
                index[url] = {
                    'title': content.get('title', ''),
                    'url': url,
                    'content_preview': content.get('markdown', '')[:500] + '...' if len(content.get('markdown', '')) > 500 else content.get('markdown', ''),
                    'extracted_at': content.get('extracted_at', '')
                }
        
        with open(os.path.join(output_dir, 'searchable_index.json'), 'w', encoding='utf-8') as f:
            json.dump(index, f, indent=2, ensure_ascii=False)
    
    def create_readme(self, output_dir: str):
        """Create a README file with extraction summary"""
        successful_pages = sum(1 for content in self.extracted_content.values() if content.get('success', False))
        total_pages = len(self.extracted_content)
        
        readme_content = f"""# Complete Riverpod Documentation Extraction

## Summary
- **Total pages extracted:** {total_pages}
- **Successful extractions:** {successful_pages}
- **Failed extractions:** {total_pages - successful_pages}
- **Base URL:** {self.base_url}
- **Extraction date:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Files Generated
- `complete_docs.json` - Complete extraction results in JSON format
- `searchable_index.json` - Searchable index of all content
- Individual markdown files for each page

## Usage
- Use `complete_docs.json` for programmatic access to all content
- Use `searchable_index.json` for quick content discovery
- Individual markdown files can be used for documentation purposes

## Extracted Documentation Pages
"""
        
        for url, content in self.extracted_content.items():
            status = "✅" if content.get('success', False) else "❌"
            title = content.get('title', 'Untitled')
            readme_content += f"- {status} [{title}]({url})\n"
        
        with open(os.path.join(output_dir, 'README.md'), 'w', encoding='utf-8') as f:
            f.write(readme_content)

async def main():
    """Main function"""
    parser = argparse.ArgumentParser(description='Complete Riverpod Documentation Crawler')
    parser.add_argument('--delay', type=float, default=2.0, help='Delay between requests (seconds)')
    parser.add_argument('--output-dir', help='Output directory')
    
    args = parser.parse_args()
    
    if not CRAWL4AI_AVAILABLE:
        print("Crawl4AI is not installed!")
        print("Install with: pip install crawl4ai")
        return
    
    print("Complete Riverpod Documentation Crawler")
    print("=" * 50)
    print(f"Delay: {args.delay}s")
    print()
    
    # Create crawler
    crawler = RiverpodFullCrawler()
    
    # Crawl all documentation
    results = await crawler.crawl_all_documentation(args.delay)
    
    # Save results
    output_dir = crawler.save_results(args.output_dir)
    
    print(f"\nExtraction completed!")
    print(f"Files saved to: {output_dir}")
    print(f"Total pages: {len(results)}")
    print(f"Successful: {sum(1 for r in results.values() if r.get('success', False))}")
    print(f"Failed: {sum(1 for r in results.values() if not r.get('success', False))}")

if __name__ == "__main__":
    asyncio.run(main())
