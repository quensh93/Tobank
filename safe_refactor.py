import sys

file_path = 'lib/stac/tobank/flows/promissory_real/dart/promissory_real_receiver_screen.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Toggle
start_toggle = "                    // Receiver Type Selection Row\n                    StacRow("
end_toggle = "                      ],\n                    ),\n                    StacSizedBox(height: 16),\n"
if start_toggle in content and end_toggle in content:
    s = content.find(start_toggle)
    e = content.find(end_toggle, s) + len(end_toggle)
    block = content[s:e]
    content = content[:s] + "                    // Receiver Type Selection Row\n                    _buildReceiverTypeToggle(),\n                    StacSizedBox(height: 16),\n" + content[e:]
    method_body = block.replace("                    // Receiver Type Selection Row\n                    ", "").replace("                    StacSizedBox(height: 16),\n", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildReceiverTypeToggle() {\n  return " + method_body + ";\n}\n"
else:
    print("Toggle markers not found")

# 2. Individual Form
start_indiv = "                    StacRawJsonWidget({\n                      'type': 'visibility',\n                      'visible': '[[isIndividualSelected]]',"
end_indiv = "                          StacSizedBox(height: 40),\n                        ],\n                      ).toJson(),\n                    }),\n"
if start_indiv in content and end_indiv in content:
    s = content.find(start_indiv)
    e = content.find(end_indiv, s) + len(end_indiv)
    block = content[s:e]
    content = content[:s] + "                    _buildIndividualForm(),\n" + content[e:]
    method_body = block.rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildIndividualForm() {\n  return " + method_body.lstrip() + ";\n}\n"
else:
    print("Indiv markers not found")

# 3. Legal Form
start_legal = "                    StacRawJsonWidget({\n                      'type': 'visibility',\n                      'visible': '[[isLegalSelected]]',"
end_legal = "                          StacSizedBox(height: 40),\n                        ],\n                      ).toJson(),\n                    }),\n"
if start_legal in content and end_legal in content:
    s = content.find(start_legal)
    e = content.find(end_legal, s) + len(end_legal)
    block = content[s:e]
    content = content[:s] + "                    _buildLegalForm(),\n" + content[e:]
    method_body = block.rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildLegalForm() {\n  return " + method_body.lstrip() + ";\n}\n"
else:
    print("Legal markers not found")

# 4. Submit Button
start_submit = "            // Continue Button (With Real API Call and Loading State)\n            StacPadding("
end_submit = "                  ),\n                ).toJson(),\n              }),\n            ),\n"
if start_submit in content and end_submit in content:
    s = content.find(start_submit)
    e = content.find(end_submit, s) + len(end_submit)
    block = content[s:e]
    content = content[:s] + "            // Continue Button (With Real API Call and Loading State)\n            _buildSubmitButton(),\n" + content[e:]
    method_body = block.replace("            // Continue Button (With Real API Call and Loading State)\n            ", "").rstrip()
    if method_body.endswith(','): method_body = method_body[:-1]
    content += "\nStacWidget _buildSubmitButton() {\n  return " + method_body + ";\n}\n"
else:
    print("Submit markers not found")

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Safe refactor complete")
