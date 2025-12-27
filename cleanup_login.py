#!/usr/bin/env python3
"""
Clean up the login_flow_linear_login.dart file by removing orphan code.
Deletes lines 407-615 which contain leftover old StacElevatedButton code.
"""

file_path = r'lib\stac\tobank\flows\login_flow_linear\dart\login_flow_linear_login.dart'

# Read the file
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

print(f"Original file has {len(lines)} lines")

# Keep lines 1-406 (index 0-405) and lines 616+ (index 615+)
# This removes lines 407-615 (index 406-614)
new_lines = lines[:406] + lines[615:]

print(f"After cleanup file has {len(new_lines)} lines")
print(f"Removed {len(lines) - len(new_lines)} lines")

# Write the file
with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print(f"Successfully cleaned up {file_path}")
