import 'package:intl/intl.dart';

class DateHelper {
  String dateFormart(String? date) {
    if (date == null) {
      return "";
    }
    List<String> dateFormat = date.split(" ");
    DateTime parsedDate = DateTime.parse(dateFormat.first);
    String formattedDate = DateFormat('EEE, MMM d').format(parsedDate);
    if(dateFormat[1] != null) {
      formattedDate = '${formattedDate} | ${dateFormat[1]} ';
    }
    return formattedDate;
  }
}