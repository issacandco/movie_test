import 'dart:io';

import 'package:flutter/material.dart';

extension StringExtension on String {
  get decodeUrl {
    return Uri.decodeFull(this);
  }

  get encodeUrl {
    return Uri.encodeFull(this);
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  bool hasValue() {
    return ![null, ''].contains(this);
  }

  String interpolate({Map<String, dynamic> params = const {}}) {
    String result = this;
    for (var key in params.keys) {
      result = result.replaceAll('{{$key}}', params[key]);
    }

    return result;
  }

  String maskContactNo() {
    int position = length - 3;
    return replaceAll(substring(0, position), List.generate(position, (index) => '*').join());
  }

  String maskEmail() {
    int position = indexOf('@');
    return replaceAll(substring(0, position), List.generate(position, (index) => '*').join());
  }

  String maskPassword() {
    int position = length;
    return replaceAll(substring(0, position), List.generate(position, (index) => '*').join());
  }

  String maskCreditCard() {
    int position = length - 4;
    return replaceAll(substring(0, position), List.generate(position, (index) => '*').join());
  }

  bool isHtmlLink() {
    return hasValue() && (contains('http://') || contains('https://'));
  }

  Widget getImageType() {
    return isHtmlLink()
        ? Image(
            image: NetworkImage(this),
            fit: BoxFit.cover,
          )
        : Image.file(
            File(this),
            fit: BoxFit.cover,
          );
  }

  String filterContactNo() {
    if (startsWith('60')) {
      return replaceFirst('60', '');
    }
    return this;
  }

  String addSpacingForContactNo() {
    var contactNo = this;
    if (startsWith('6')) {
      contactNo = contactNo.substring(1, contactNo.length);
    }

    if (length <= 11) {
      return '+6${contactNo.substring(0, 1)} ${contactNo.substring(1, 4)} ${contactNo.substring(4, 7)} ${contactNo.substring(7, contactNo.length)}';
    }
    if (length <= 12) {
      return '+6${contactNo.substring(0, 2)} ${contactNo.substring(2, 5)} ${contactNo.substring(5, 8)} ${contactNo.substring(8, contactNo.length)}';
    }
    return '';
  }

  String removeTrailingZeros() {
    return replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
  }

  String toCapitalized() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
