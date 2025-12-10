# -*- coding: utf-8 -*-
import json
import codecs

file_path = r'lib\stac\tobank\login\json\tobank_login.json'

# Read JSON
with codecs.open(file_path, 'r', 'utf-8') as f:
    data = json.load(f)

# Navigate to the dialog widget and fix the text
results = data['body']['child']['children'][1]['child']['onPressed']['isValid']['results']
dialog_widget = results[0]['action']['widget']

# Fix the "پاسخ دریافت شده:" text
for child in dialog_widget['content']['child']['children']:
    if child.get('type') == 'text' and 'data' in child:
        text = child['data']
        # Fix "پاسخ دریافت شده:" - check for garbled version
        if 'Ù¾Ø§Ø³Ø®' in text:
            child['data'] = 'پاسخ دریافت شده:'
            print(f'Fixed: پاسخ دریافت شده:')
        # Fix the response message
        elif 'Status: 200 OK' in text:
            # Replace the entire response text with correct Persian
            if 'Ú©Ø¯' in text or 'Ú©' in text or 'کد تایید' in text:
                # Build the correct response text with escaped quotes for JSON
                child['data'] = 'Status: 200 OK\n\nResponse:\n{\n  "success": true,\n  "message": "کد تایید با موفقیت ارسال شد",\n  "otpCode": "123456",\n  "expiresIn": 120\n}'
                print(f'Fixed: Response message')

# Write back with proper formatting
with codecs.open(file_path, 'w', 'utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print('Fixed dialog text')
