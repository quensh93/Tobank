import sys

file_path = 'lib/stac/tobank/flows/promissory_real/dart/promissory_real_sign_screen.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. AppBar
start_appbar = "      appBar: StacAppBar("
end_appbar = "        ),\n      ),\n      body: StacColumn("
if start_appbar in content and end_appbar in content:
    s = content.find(start_appbar)
    e = content.find(end_appbar, s) + len(end_appbar) - len("      body: StacColumn(")
    block = content[s:e]
    content = content[:s] + "      appBar: _buildAppBar(),\n" + content[e:]
    method_body = block.replace("      appBar: StacAppBar(", "StacAppBar(").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacAppBar _buildAppBar() {\n  return " + method_body + ";\n}\n"
else:
    print("AppBar markers not found")

# 2. Loading State
start_loading = "                // ── Loading State ──\n                {"
end_loading = "                    },\n                  },\n                },\n"
if start_loading in content and end_loading in content:
    s = content.find(start_loading)
    e = content.find(end_loading, s) + len(end_loading)
    block = content[s:e]
    content = content[:s] + "                // ── Loading State ──\n                _buildLoadingState(),\n" + content[e:]
    method_body = block.replace("                // ── Loading State ──\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nMap<String, dynamic> _buildLoadingState() {\n  return " + method_body + ";\n}\n"
else:
    print("Loading markers not found")

# 3. Error State
start_error = "                // ── Error State ──\n                {"
if start_error in content and end_loading in content[content.find(start_error):]:
    s = content.find(start_error)
    e = content.find(end_loading, s) + len(end_loading)
    block = content[s:e]
    content = content[:s] + "                // ── Error State ──\n                _buildErrorState(),\n" + content[e:]
    method_body = block.replace("                // ── Error State ──\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nMap<String, dynamic> _buildErrorState() {\n  return " + method_body + ";\n}\n"
else:
    print("Error markers not found")

# 4. Success State
start_success = "                // ── Success State (Sign Content) ──\n                {"
end_success = "                    ).toJson(),\n                  },\n                },\n"
if start_success in content and end_success in content:
    s = content.find(start_success)
    e = content.find(end_success, s) + len(end_success)
    block = content[s:e]
    content = content[:s] + "                // ── Success State (Sign Content) ──\n                _buildSuccessState(),\n" + content[e:]
    method_body = block.replace("                // ── Success State (Sign Content) ──\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nMap<String, dynamic> _buildSuccessState() {\n  return " + method_body + ";\n}\n"
else:
    print("Success markers not found")

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Sign refactor complete")
