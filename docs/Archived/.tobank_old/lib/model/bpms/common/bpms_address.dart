import 'bpms_address_value.dart';

class BPMSAddress {
  BPMSAddress({
    required this.value,
  });

  BPMSAddressValue value;

  factory BPMSAddress.fromJson(Map<String, dynamic> json) => BPMSAddress(
        value: BPMSAddressValue.fromJson(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}
