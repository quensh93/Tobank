// Only import dart:html when building for web
// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart' as html;
import 'dart:convert';

/// Triggers a download of [text] into a file called [filename].
/// Works only in Flutter Web.
void downloadTextFile(String filename, String text) {
  // Encode the text to a list of UTF-8 bytes
  final List<int> bytes = utf8.encode(text);

  // Create a Blob from the bytes
  final blob = html.Blob([bytes], 'text/plain', 'native');

  // Generate a URL for that Blob
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Create a hidden anchor element
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', filename)
    ..style.display = 'none';

  // Add to DOM, click it, then remove it
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();

  // Revoke the object URL to free up memory
  html.Url.revokeObjectUrl(url);
}
