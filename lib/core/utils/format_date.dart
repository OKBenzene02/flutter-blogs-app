import 'package:intl/intl.dart';

String formateDateByddMMYYY(DateTime dateTime) {
  return DateFormat('dd MMM, yyyy').format(dateTime);
}
