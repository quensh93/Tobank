class TransactionFilterData {
  String? isWallet = '0';
  List<int> services = [];
  String? isCredit;
  String? dateFromGregorian;
  String? dateToGregorian;
  String? isSuccess;
  String? dateFromJalali;
  String? dateToJalali;
  String? sort;
  String? inquiryIsOwn;
  int? page;
  int limit = 20;

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};

    queryParameters['limit'] = limit;

    if (isWallet != null) {
      queryParameters['is_wallet'] = isWallet;
    }

    if (services.isNotEmpty) {
      final String servicesJoined = services.map((e) => e.toString()).join(',');
      queryParameters['service'] = servicesJoined;
    }

    if (isCredit != null) {
      queryParameters['is_credit'] = isCredit;
    }

    if (dateFromGregorian != null) {
      queryParameters['date_from'] = dateFromGregorian;
    }

    if (dateToGregorian != null) {
      queryParameters['date_to'] = dateToGregorian;
    }

    if (isSuccess != null) {
      queryParameters['is_success'] = isSuccess;
    }

    if (sort != null) {
      queryParameters['sort'] = sort;
    }

    if (inquiryIsOwn != null) {
      queryParameters['inquiry_is_own'] = inquiryIsOwn;
    }

    if (page != null) {
      queryParameters['page'] = page;
    }

    return queryParameters;
  }
}
