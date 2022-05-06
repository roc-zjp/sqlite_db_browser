// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const String APP_NAME = "Sqlite Browser";
var logger = Logger(
  printer: PrettyPrinter(),
);

bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

bool get isDesktopDevice =>
    !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;

bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
