import os
import re

DIR = "lib/stac/ready_for_build"

# List of classes explicitly inlined by the migration script
CLASSES = [
    "StacStatefulWidget",
    "StacRawJsonWidget",
    "StacRawJsonAction",
    "StacSequenceAction",
    "StacNetworkRequestAction",
    "StacCustomSetValueAction",
    "StacGetFormValueAction",
    "StacAliasTextStyle",
    "StacValidateFieldsAction",
    "StacPersianDatePickerAction",
    "StacLogAction"
]

TYPEDEFS = [
    "StacMultiAction"
]

def find_class_ranges(content, class_name):
    ranges = []
    # Match "class ClassName" followed by brace or space
    pattern = re.compile(r'class\s+' + re.escape(class_name) + r'(?:\s|{)')
    
    for match in pattern.finditer(content):
        start_idx = match.start()
        open_brace_idx = content.find('{', match.end() - 1)
        if open_brace_idx == -1: 
            continue
        
        count = 1
        idx = open_brace_idx + 1
        while idx < len(content) and count > 0:
            if content[idx] == '{':
                count += 1
            elif content[idx] == '}':
                count -= 1
            idx += 1
        
        if count == 0:
            ranges.append((start_idx, idx))

    return ranges

def find_typedef_ranges(content, type_name):
    # Matches "typedef Name = ...;"
    ranges = []
    pattern = re.compile(r'typedef\s+' + re.escape(type_name) + r'\s*=.*?;')
    for match in pattern.finditer(content):
        ranges.append(match.span())
    return ranges

def fix_dangling_hides(content):
    # Fixes lines that start with "    hide ...;" which were left behind by incomplete import stripping
    lines = content.splitlines()
    new_lines = []
    for line in lines:
        if line.strip().startswith("hide ") and line.strip().endswith(";"):
            # This is likely a dangling combinator from a removed import
            print("Found dangling hide: " + line.strip())
            continue # Skip it (delete it)
        new_lines.append(line)
    return "\n".join(new_lines)

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Fix Dangling Hides (Text based)
    content = fix_dangling_hides(content)

    # 2. Fix Duplicates (Ranges based)
    original_len = len(content)
    ranges_to_remove = []

    for cls in CLASSES:
        ranges = find_class_ranges(content, cls)
        if len(ranges) > 1:
            # Remove all except the last one (assuming last is the appended master block)
            for r in ranges[:-1]:
                ranges_to_remove.append(r)
                print(f"[{os.path.basename(filepath)}] Duplicate {cls}: Marking index {r[0]}-{r[1]} for removal.")

    for td in TYPEDEFS:
        ranges = find_typedef_ranges(content, td)
        if len(ranges) > 1:
            for r in ranges[:-1]:
                ranges_to_remove.append(r)
                print(f"[{os.path.basename(filepath)}] Duplicate {td}: Marking index {r[0]}-{r[1]} for removal.")

    if ranges_to_remove:
        # Sort ranges descending to remove safely
        ranges_to_remove.sort(key=lambda x: x[0], reverse=True)
        file_content_list = list(content)
        for start, end in ranges_to_remove:
            del file_content_list[start:end]
        content = "".join(file_content_list)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Fixed {os.path.basename(filepath)}")

def main():
    if not os.path.exists(DIR):
        print(f"Directory {DIR} does not exist.")
        return

    files = [f for f in os.listdir(DIR) if f.endswith(".dart")]
    for f in files:
        process_file(os.path.join(DIR, f))

if __name__ == "__main__":
    main()
