class DocumentFile {
  DocumentFileValue? value;

  DocumentFile({
    required this.value,
  });

  factory DocumentFile.fromJson(Map<String, dynamic> json) => DocumentFile(
        value: json['value'] == null ? null : DocumentFileValue.fromJson(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'value': value?.toJson(),
      };
}

class DocumentFileValue {
  String? id;
  int? status; // optional and unknown: null, unconfirmed: 0, rejected: 1, accepted 2
  String? title;
  String? description;

  DocumentFileValue({
    required this.id,
    required this.status,
    required this.title,
    required this.description,
  });

  factory DocumentFileValue.fromJson(Map<String, dynamic> json) => DocumentFileValue(
        id: json['id'],
        status: json['status'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'title': title,
        'description': description,
      };
}
