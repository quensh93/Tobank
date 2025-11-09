/// Extensions for String type
extension StringExtensions on String {
  /// Check if the string is a valid email
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  /// Check if the string is a valid phone number
  bool get isValidPhone {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(this);
  }

  /// Check if the string is a valid URL
  bool get isValidUrl {
    return Uri.tryParse(this)?.hasAbsolutePath ?? false;
  }

  /// Check if the string is empty or null
  bool get isNullOrEmpty => isEmpty;

  /// Check if the string is not empty and not null
  bool get isNotNullOrEmpty => !isEmpty;

  /// Capitalize the first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalize the first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string to a given length
  String truncate(int length, {String suffix = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$suffix';
  }

  /// Remove all whitespace from the string
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove HTML tags from the string
  String get removeHtmlTags => replaceAll(RegExp(r'<[^>]*>'), '');

  /// Convert string to slug
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Mask the string (e.g., for email or phone)
  String get maskEmail {
    if (!isValidEmail) return this;
    final parts = split('@');
    if (parts.length != 2) return this;
    final email = parts[0];
    final domain = parts[1];
    if (email.length <= 2) {
      return '${email[0]}***@$domain';
    }
    return '${email[0]}***${email[email.length - 1]}@$domain';
  }

  /// Mask the phone number
  String get maskPhone {
    if (length <= 4) return this;
    final visible = substring(length - 4);
    return '${'*' * (length - 4)}$visible';
  }
}
