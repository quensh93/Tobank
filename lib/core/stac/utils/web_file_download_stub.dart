Future<void> downloadFileFromBytes({
  required List<int> bytes,
  required String fileName,
  required String mimeType,
}) async {
  throw UnsupportedError('Web file download is only supported on web.');
}
