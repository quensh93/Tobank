class CollateralPromissoryPublishResultData {
  CollateralPromissoryPublishResultData({
    required this.isSuccess,
    required this.message,
    required this.promissoryId,
    required this.promissoryPdfBase64,
  });

  final bool isSuccess;
  final String message;
  final String? promissoryId;
  final String? promissoryPdfBase64;
}
