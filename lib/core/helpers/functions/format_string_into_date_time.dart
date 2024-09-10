

import 'package:intl/intl.dart';

String formatStringIntoDateTime(String dateString) {
  try {
    // Parse the date string to DateTime
    final DateTime dateTime = DateTime.parse(dateString);

    // Define date and time formats
    final DateFormat dayFormat = DateFormat('EEEE'); // Full day name
    final DateFormat timeFormat = DateFormat('h:mm a'); // 12-hour format with AM/PM

    // Format the day and time
    final String day = dayFormat.format(dateTime);
    final String time = timeFormat.format(dateTime);

    // Return the formatted string
    return '$day at $time';
  } catch (e) {
    return 'Invalid date format';
  }
}
