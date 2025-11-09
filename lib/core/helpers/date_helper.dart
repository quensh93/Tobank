import '../constants/app_constants.dart';

/// Helper class for date operations
class DateHelper {
  /// Parse a string date to DateTime
  static DateTime? parse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.tryParse(dateString);
  }

  /// Format DateTime to string
  static String format(
    DateTime date, {
    String format = AppConstants.dateFormat,
  }) {
    String formatted = format;
    formatted = formatted.replaceAll('yyyy', date.year.toString());
    formatted = formatted.replaceAll('MM', date.month.toString().padLeft(2, '0'));
    formatted = formatted.replaceAll('dd', date.day.toString().padLeft(2, '0'));
    formatted = formatted.replaceAll('HH', date.hour.toString().padLeft(2, '0'));
    formatted = formatted.replaceAll('mm', date.minute.toString().padLeft(2, '0'));
    formatted = formatted.replaceAll('ss', date.second.toString().padLeft(2, '0'));
    return formatted;
  }

  /// Get relative time string (e.g., "2 hours ago")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Check if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Check if a date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if a date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }
}
