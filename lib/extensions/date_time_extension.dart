import 'package:intl/intl.dart';

class DateConstant {
  static const String basicDateFormat = 'dd-MMM-yyyy';
  static const String dateFormatWithoutDash = 'dd MMM yyyy';
  static const String weekOfDayFormat = 'E';
  static const String dayFormat = 'dd';
  static const String monthFormat = 'MMM';
  static const String dateTimeFormat = 'dd MMM, hh:mm a';
}

extension DateTimeExtension on DateTime {
  String dateFormat({String? format}) {
    return DateFormat(format ?? DateConstant.basicDateFormat).format(this);
  }

  int getParsedMillisecondsDateTime() {
    return millisecondsSinceEpoch;
  }

  bool isSameDay(DateTime dateTime) {
    return year == dateTime.year && month == dateTime.month && day == dateTime.day;
  }

  bool isDayBefore(DateTime dateTime) {
    if (year <= dateTime.year && month <= dateTime.month) {
      return day < dateTime.day;
    } else {
      return false;
    }
  }

  bool isSameDayOrAfter({DateTime? dateTime}) {
    DateTime currentDateTime = dateTime ?? DateTime.now();
    if (isSameDay(currentDateTime)) {
      return true;
    } else {
      return isAfter(currentDateTime);
    }
  }

  bool isBeforeOrSameDay({DateTime? dateTime}) {
    DateTime currentDateTime = dateTime ?? DateTime.now();
    if (isBefore(currentDateTime)) {
      return true;
    } else {
      return isSameDay(currentDateTime);
    }
  }

  bool isBetween(int startDateTimeInt, int endDateTimeInt) {
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDateTimeInt);
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(endDateTimeInt);
    return isSameDayOrAfter(dateTime: startDateTime) && isBeforeOrSameDay(dateTime: endDateTime);
  }

  bool isBetweenDateTime(DateTime? startDateTime, DateTime? endDateTime) {
    if (startDateTime == null || endDateTime == null) return false;
    return isSameDayOrAfter(dateTime: startDateTime) && isBeforeOrSameDay(dateTime: endDateTime);
  }

  bool isSameMoment(DateTime dateTime) {
    return isAtSameMomentAs(dateTime);
  }

  bool isBeforeMoment(DateTime dateTime) {
    return compareTo(dateTime) < 0;
  }

  bool isAfterMoment(DateTime dateTime) {
    return compareTo(dateTime) > 0;
  }

  DateTime getDateTime({int? inputYear, int? inputMonth, int? inputDay}) {
    return DateTime(
      year + (inputYear ?? 0),
      month + (inputMonth ?? 0),
      day + (inputDay ?? 0),
    );
  }
}

extension DateTimeMillisecondsExtension on int {
  DateTime? parseDateTimeByMilliseconds() {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this);
    } catch (e) {
      return null;
    }
  }

  String parseDateTimeByMillisecondsToString({String? format}) {
    try {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
      return DateFormat(format ?? 'dd-MMM-yyyy, hh:mm:ss a').format(dateTime);
    } catch (e) {
      return toString();
    }
  }

  String parseIntIntoMinutes() {
    return Duration(seconds: this).toString().split('.').first.padLeft(8, '0');
  }
}

extension StringDateTimeExtension on String {
  int parseStringDateTimeToMillSeconds() {
    String formattedDate = '${substring(0, 10)} ${substring(11)}';
    return DateTime.parse(formattedDate).toLocal().millisecondsSinceEpoch;
  }

  String parseStringToDateTimeString({String? format, bool isConvertToLocal = false}) {
    DateTime parsedDate = isConvertToLocal ? DateTime.parse(this).toLocal() : DateTime.parse(this);
    String dateString = DateFormat(format ?? DateConstant.basicDateFormat).format(parsedDate);
    return dateString;
  }

  String parseFormattedStringToDateTimeString(String formattedDate, {String? format}) {
    return DateFormat(format ?? DateConstant.basicDateFormat).format(DateFormat(formattedDate).parse(this));
  }

  DateTime parseStringToDateTime({bool isConvertToLocal = false}) {
    return isConvertToLocal ? DateTime.parse(this).toLocal() : DateTime.parse(this);
  }
}
