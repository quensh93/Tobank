import sys

file_path = 'lib/stac/tobank/flows/promissory_real/dart/promissory_real_receiver_screen.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

def get_block(start, end):
    return "".join(lines[start-1:end])

app_bar_code = get_block(26, 43)
app_bar_code = app_bar_code.replace('appBar: StacAppBar(', 'StacAppBar _buildAppBar() {\n  return StacAppBar(')
app_bar_code = app_bar_code.rstrip()
if app_bar_code.endswith(','): app_bar_code = app_bar_code[:-1]
app_bar_code += ';\n}\n\n'

toggle_code = get_block(70, 235)
toggle_code = 'StacWidget _buildReceiverTypeToggle() {\n  return ' + toggle_code.lstrip()
toggle_code = toggle_code.rstrip()
if toggle_code.endswith(','): toggle_code = toggle_code[:-1]
toggle_code += ';\n}\n\n'

indiv_code = get_block(237, 416)
indiv_code = 'StacWidget _buildIndividualForm() {\n  return ' + indiv_code.lstrip()
indiv_code = indiv_code.rstrip()
if indiv_code.endswith(','): indiv_code = indiv_code[:-1]
indiv_code += ';\n}\n\n'

legal_code = get_block(417, 589)
legal_code = 'StacWidget _buildLegalForm() {\n  return ' + legal_code.lstrip()
legal_code = legal_code.rstrip()
if legal_code.endswith(','): legal_code = legal_code[:-1]
legal_code += ';\n}\n\n'

btn_code = get_block(595, 881)
btn_code = 'StacWidget _buildSubmitButton() {\n  return ' + btn_code.lstrip()
btn_code = btn_code.rstrip()
if btn_code.endswith(','): btn_code = btn_code[:-1]
btn_code += ';\n}\n\n'

new_lines = []
new_lines.extend(lines[0:25])
new_lines.append('      appBar: _buildAppBar(),\n')
new_lines.extend(lines[43:68])
new_lines.append('                    // Receiver Type Selection Row\n')
new_lines.append('                    _buildReceiverTypeToggle(),\n')
new_lines.append('                    StacSizedBox(height: 16),\n')
new_lines.append('                    _buildIndividualForm(),\n')
new_lines.append('                    _buildLegalForm(),\n')
new_lines.extend(lines[589:593])
new_lines.append('            // Continue Button (With Real API Call and Loading State)\n')
new_lines.append('            _buildSubmitButton(),\n')
new_lines.extend(lines[881:887])

new_file_content = "".join(new_lines) + "\n" + app_bar_code + toggle_code + indiv_code + legal_code + btn_code

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_file_content)

print('Refactoring complete')
