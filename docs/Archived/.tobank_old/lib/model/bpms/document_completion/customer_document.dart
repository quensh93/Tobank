class CustomerDocument {
  String? id;
  int? type;
  int? status;
  String? title;
  String? description;
  int? index;

  CustomerDocument({
    this.id,
    this.type,
    this.status,
    this.title,
    this.description,
  });

  factory CustomerDocument.fromJson(Map<String, dynamic> json) => CustomerDocument(
        id: json['id'],
        type: json['type'],
        status: json['status'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}
