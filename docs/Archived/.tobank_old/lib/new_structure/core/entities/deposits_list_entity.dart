import '../../../model/bpms/parsa_loan/response/check_deposit_response_data.dart';

class DepositsListEntity {
  final String depositNumber;
  final String depositIban;
  final String currentAmount;
  final String currentWithdrawAmount;
  final String errorMessage;
  final String withdrawRight;
  final String depositState;
  final String depositTitle;
  final String depositTypeNumber;
  final String depositTypeTitle;
  final String customerRelationWithDepositPersian;
  final String customerRelationWithDepositEnglish;
  final String portion;
  final String isSpecial;
  final String mainCustomerNumber;
  final String currencySwiftCode;
  final String fullName;
  final String individualOrSharedDeposit;
  final List<SignerInfo> signerInfo;
  final List<CardInfo>? cards; // New field added

  DepositsListEntity({
    required this.depositNumber,
    required this.depositIban,
    required this.currentAmount,
    required this.currentWithdrawAmount,
    required this.errorMessage,
    required this.withdrawRight,
    required this.depositState,
    required this.depositTitle,
    required this.depositTypeNumber,
    required this.depositTypeTitle,
    required this.customerRelationWithDepositPersian,
    required this.customerRelationWithDepositEnglish,
    required this.portion,
    required this.isSpecial,
    required this.mainCustomerNumber,
    required this.currencySwiftCode,
    required this.fullName,
    required this.individualOrSharedDeposit,
    required this.signerInfo,
     this.cards, // Added to constructor
  });

  factory DepositsListEntity.fromJson(Map<String, dynamic> json) {
    return DepositsListEntity(
      depositNumber: json['depositNumber'] as String,
      depositIban: json['depositIban'] as String,
      currentAmount: json['currentAmount'] as String,
      currentWithdrawAmount: json['currentWithdrawAmount'] as String,
      errorMessage: json['errorMessage'] as String,
      withdrawRight: json['withdrawRight'] as String,
      depositState: json['depositState'] as String,
      depositTitle: json['depositTitle'] as String,
      depositTypeNumber: json['depositTypeNumber'] as String,
      depositTypeTitle: json['depositTypeTitle'] as String,
      customerRelationWithDepositPersian: json['customerRelationWithDepositPersian'] as String,
      customerRelationWithDepositEnglish: json['customerRelationWithDepositEnglish'] as String,
      portion: json['portion'] as String,
      isSpecial: json['isSpecial'] as String,
      mainCustomerNumber: json['MainCustomerNumber'] as String,
      currencySwiftCode: json['CurrencySwiftCode'] as String,
      fullName: json['FullName'] as String,
      individualOrSharedDeposit: json['IndividualOrSharedDeposit'] as String,
      signerInfo: (json['SignerInfo'] as List<dynamic>)
          .map((e) => SignerInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      cards:  ((json['cards'] ?? []) as List<dynamic>)
          .map((e) => CardInfo.fromJson(e as Map<String, dynamic>))
          .toList(), // Added parsing for cards
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'depositNumber': depositNumber,
      'depositIban': depositIban,
      'currentAmount': currentAmount,
      'currentWithdrawAmount': currentWithdrawAmount,
      'errorMessage': errorMessage,
      'withdrawRight': withdrawRight,
      'depositState': depositState,
      'depositTitle': depositTitle,
      'depositTypeNumber': depositTypeNumber,
      'depositTypeTitle': depositTypeTitle,
      'customerRelationWithDepositPersian': customerRelationWithDepositPersian,
      'customerRelationWithDepositEnglish': customerRelationWithDepositEnglish,
      'portion': portion,
      'isSpecial': isSpecial,
      'MainCustomerNumber': mainCustomerNumber,
      'CurrencySwiftCode': currencySwiftCode,
      'FullName': fullName,
      'IndividualOrSharedDeposit': individualOrSharedDeposit,
      'SignerInfo': signerInfo.map((e) => e.toJson()).toList(),
      'cards': (cards??[]).map((e) => e.toJson()).toList(), // Added serialization for cards
    };
  }

  @override
  String toString() {
    return '🔵 DepositsListEntity(\n'
        '  depositNumber: $depositNumber\n'
        '  depositIban: $depositIban\n'
        '  currentAmount: $currentAmount\n'
        '  currentWithdrawAmount: $currentWithdrawAmount\n'
        '  errorMessage: $errorMessage\n'
        '  withdrawRight: $withdrawRight\n'
        '  depositState: $depositState\n'
        '  depositTitle: $depositTitle\n'
        '  depositTypeNumber: $depositTypeNumber\n'
        '  depositTypeTitle: $depositTypeTitle\n'
        '  customerRelationWithDepositPersian: $customerRelationWithDepositPersian\n'
        '  customerRelationWithDepositEnglish: $customerRelationWithDepositEnglish\n'
        '  portion: $portion\n'
        '  isSpecial: $isSpecial\n'
        '  mainCustomerNumber: $mainCustomerNumber\n'
        '  currencySwiftCode: $currencySwiftCode\n'
        '  fullName: $fullName\n'
        '  individualOrSharedDeposit: $individualOrSharedDeposit\n'
        '  signerInfo: $signerInfo\n'
        '  cards: ${cards ?? []}\n' // Added to string representation
        ')';
  }
}



class CardInfo {
  final String number;
  final int state;

  CardInfo({
    required this.number,
    required this.state,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      number: json['number'] as String,
      state: json['state'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'state': state,
    };
  }

  @override
  String toString() {
    return 'CardInfo(number: $number, state: $state)';
  }
}