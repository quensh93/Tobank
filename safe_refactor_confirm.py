import sys

file_path = 'lib/stac/tobank/flows/promissory_real/dart/promissory_real_confirm_screen.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. AppBar
start_appbar = "    appBar: StacAppBar("
end_appbar = "      ),\n    ),\n    body: StacColumn("
if start_appbar in content and end_appbar in content:
    s = content.find(start_appbar)
    e = content.find(end_appbar, s) + len(end_appbar) - len("    body: StacColumn(")
    block = content[s:e]
    content = content[:s] + "    appBar: _buildAppBar(),\n" + content[e:]
    method_body = block.replace("    appBar: StacAppBar(", "StacAppBar(").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacAppBar _buildAppBar() {\n  return " + method_body + ";\n}\n"
else:
    print("AppBar markers not found")

# 2. Promissory Details Section
start_prom = "                // Promissory Details Section\n                StacContainer("
end_prom = "                  ),\n                ),\n\n                StacSizedBox(height: 16),\n\n                // Issuer Section"
if start_prom in content and end_prom in content:
    s = content.find(start_prom)
    e = content.find(end_prom, s) + len("                  ),\n                ),\n")
    block = content[s:e]
    content = content[:s] + "                // Promissory Details Section\n                _buildPromissoryDetails(),\n" + content[e:]
    method_body = block.replace("                // Promissory Details Section\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildPromissoryDetails() {\n  return " + method_body + ";\n}\n"
else:
    print("Prom markers not found")

# 3. Issuer Section
start_issuer = "                // Issuer Section\n                StacContainer("
end_issuer = "                  ),\n                ),\n                StacSizedBox(height: 16),\n\n                // Receiver Section"
if start_issuer in content and end_issuer in content:
    s = content.find(start_issuer)
    e = content.find(end_issuer, s) + len("                  ),\n                ),\n")
    block = content[s:e]
    content = content[:s] + "                // Issuer Section\n                _buildIssuerSection(),\n" + content[e:]
    method_body = block.replace("                // Issuer Section\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildIssuerSection() {\n  return " + method_body + ";\n}\n"
else:
    print("Issuer markers not found")

# 4. Receiver Section
start_receiver = "                // Receiver Section\n                StacContainer("
end_receiver = "                  ),\n                ),\n              ],\n            ),\n          ),\n        ),\n        // Submit Button"
if start_receiver in content and end_receiver in content:
    s = content.find(start_receiver)
    e = content.find(end_receiver, s) + len("                  ),\n                ),\n")
    block = content[s:e]
    content = content[:s] + "                // Receiver Section\n                _buildReceiverSection(),\n" + content[e:]
    method_body = block.replace("                // Receiver Section\n                ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildReceiverSection() {\n  return " + method_body + ";\n}\n"
else:
    print("Receiver markers not found")

# 5. Submit Button
start_submit = "        // Submit Button\n        StacPadding("
end_submit = "          ),\n        ),\n      ],\n    ),\n  );\n}\n"
if start_submit in content and end_submit in content:
    s = content.find(start_submit)
    e = content.find(end_submit, s) + len("          ),\n        ),\n")
    block = content[s:e]
    content = content[:s] + "        // Submit Button\n        _buildSubmitButton(),\n" + content[e:]
    method_body = block.replace("        // Submit Button\n        ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildSubmitButton() {\n  return " + method_body + ";\n}\n"
else:
    print("Submit markers not found")


with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Safe refactor complete")
