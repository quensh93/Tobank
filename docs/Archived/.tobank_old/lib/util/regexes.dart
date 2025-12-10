class RegexValue {
  var acceptorNameReg = RegExp(r'^[a-zA-Zآ-ی ء چ]+$');
  var mobileReg = RegExp(
      r'(0|\+98)?([ ]|-|[()]){0,2}9[0-9]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}');
  var phoneReg = RegExp(r'^0[0-9]\d{1,9}$');
  static var emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  var acceptorPassReg =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*[&%$]).{6,}$');
  var acceptorDynamicPassReg = RegExp(r'^\d{7}$');
  var acceptorWalletReg = RegExp(r'^[a-zA-Z0-9-_]+$');
  var acceptorWalletPassReg =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*[&%$]).{6,}$');
  var bankNameReg = RegExp(r'^.{2,}$');
  var ipReg = RegExp(
      r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  var acceptorSiteReg = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})');
  var shebaReg = RegExp(r'^.{24,24}$');
  var acceptorWalletSettlementDescReg = RegExp(r'^.{5,}$');
  var acceptorJobTitleReg = RegExp(r'^[a-zA-Zآ-ی ء چ]+.{2,}$');
  var acceptorCompanyNameReg = RegExp(r'^[a-zA-Zآ-ی ء چ]+.{2,}$');
  var acceptorCompanyNationalCodeReg = RegExp(r'^.{3,}$');
  var acceptorCompanyFinancialCodeReg = RegExp(r'^.{3,}$');
  var acceptorPostalCodeReg = RegExp(r'^\d{10}$');
  var acceptorAddressReg = RegExp(r'^.{10,}$');
  var acceptorCompanyGuildTitle = RegExp(r'^[a-zA-Zآ-ی ء چ]+.{2,}$');

  static var virtualBranchAddressRegex = RegExp(
      "^[آ-ی ‌ءچ،\\s\\d\\-!#\$%&()*+,./:;<=>?–@\\[\\]^_'{}~\\\\]{1,128}");
}
