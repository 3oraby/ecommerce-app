import 'package:intl/intl.dart';

String formatStringIntoDateTime(String dateString,
    {bool showTotalDate = false}) {
  try {
    DateTime dateTime = DateTime.parse(dateString);

    dateTime = dateTime.add(const Duration(hours: 3));

    final DateFormat dayFormat = DateFormat('EEEE');
    final DateFormat monthFormat = DateFormat('MMMM');
    final DateFormat timeFormat = DateFormat('h:mm a');

    final String day = dayFormat.format(dateTime);
    final String month = monthFormat.format(dateTime);
    final String time = timeFormat.format(dateTime);

    if (showTotalDate) {
      return '$day, $month at $time';
    }
    return '$day at $time';
  } catch (e) {
    return 'Invalid date format';
  }
}
