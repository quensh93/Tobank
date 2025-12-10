class EditSimCardParams {
  final String simcard;
  final String title;
  final bool deleteNumber;

  const EditSimCardParams({
    required this.simcard,
    required this.title,
    required this.deleteNumber,
  });

  factory EditSimCardParams.fromJson(Map<String, dynamic> json) {
    return EditSimCardParams(
      simcard: json['simcard'] as String,
      title: json['title'] as String,
      deleteNumber: json['delete_number'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'simcard': simcard.trim(),
      'title': title.trim(),
      'delete_number': deleteNumber,
    };



    return data;
  }

  @override
  String toString() {
    return 'EditSimCardParams(\n'
        'simcard: "$simcard"\n'
        'title: "$title"\n'
        'deleteNumber: $deleteNumber\n'
        ')';
  }
}