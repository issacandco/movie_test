import 'dart:math';

extension FileBytesExtension on int {
  String getReadableFileSize() {
    if (this <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int measurement = 1000; // 1024
    var i = (log(this) / log(measurement)).floor();
    return '${(this / pow(measurement, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  double getSize() {
    if (this <= 0) return 0;
    int measurement = 1000; // 1024
    // return (this / pow(measurement, 2)).floor();
    return this / pow(measurement, 2);
  }
}
