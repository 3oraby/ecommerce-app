import 'package:intl/intl.dart';

String formatStringIntoDateTime(String dateString, {bool showTotalDate = false}) {
  try {
    // Parse the date string to DateTime
    final DateTime dateTime = DateTime.parse(dateString);

    // Define date and time formats
    final DateFormat dayFormat = DateFormat('EEEE'); // Full day name
    final DateFormat monthFormat = DateFormat('MMMM'); // Full month name
    final DateFormat timeFormat = DateFormat('h:mm a'); // 12-hour format with AM/PM

    // Format the day, month, and time
    final String day = dayFormat.format(dateTime);
    final String month = monthFormat.format(dateTime);
    final String time = timeFormat.format(dateTime);

    if(showTotalDate){
      // Return the formatted string with day, month, and time
    return '$day, $month at $time';
    }
    return '$day at $time';


  } catch (e) {
    return 'Invalid date format';
  }
}
