import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_test/utils/get_storage_util.dart';

import 'app/app.dart';

FutureOr<void> main() async {
  await _initStorage();

  runApp(const App());
}

Future<void> _initStorage() async {
  try {
    bool initialized = await GetStorageUtil.initGetStorage();
    debugPrint(initialized ? 'Get Storage Initialized' : 'Get Storage Failed');
  } catch (e) {
    debugPrint('Get Storage Failed: $e');
  }
}
