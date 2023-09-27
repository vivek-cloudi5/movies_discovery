// ignore_for_file: constant_identifier_names, deprecated_member_use, unused_import

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movies_discovery/res/styles.dart';
import 'package:movies_discovery/service/local_db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppLifecycleState? appLifecycleState;
SharedPreferences? sharedPreferences;
DateFormat myDefaultDateFormat = DateFormat('MMMM dd, yyyy');
DateFormat myDefaultDateFormatSecond = DateFormat('yyyy-MM-dd');
DateFormat myDefaultDateFormatThree = DateFormat('dd-MM-yyyy');
String myDollarSymbol = "\$";
String myDbName = "movies.db";
DbHelper? localDBHelper;

/// GET RUNNING PLATFORM
String getPlatformDetail() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  } else if (Platform.isWindows) {
    return 'windows';
  } else if (Platform.isMacOS) {
    return 'mac';
  }
  return '';
}

/// SHOW DATE PICKER DIALOG
Future<DateTime?> showDatePickerDialog(
    BuildContext context, DateTime selectedDate, String? title) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: selectedDate,
      firstDate: title == 'past' ? DateTime(1900) : title == 'past' ? DateTime(DateTime.now().year - 5 , DateTime.now().month, DateTime.now().day) : DateTime.now(),
      lastDate: title == 'future' ? DateTime(2500) : DateTime.now(),
      builder: (BuildContext buildContext, Widget? child) {
        return Theme(
          data: ThemeData(
            // splashColor: green100,
            colorScheme: const ColorScheme.light(
                // change the border color
                primary: Colors.blue,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                // change the text color
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
  if (picked != null) {
    return picked;
  }
  return null;
}

/// SHOW TIME PICKER DIALOG
Future<TimeOfDay?> showTimePickerDialog(
    BuildContext context, TimeOfDay dayTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: dayTime,
    initialEntryMode: TimePickerEntryMode.dial,
  );
  if (picked != null) {
    return picked;
  }
  return null;
}

/// SHOW SNACKBAR DIALOG
void showSuccessSnackBar(String message, BuildContext context) {
  try {
    final snackDemo = SnackBar(
      content: Text(
        message,
        style: zzRegularWhite15,
      ),
      // backgroundColor: green500,
      elevation: 10,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      action: SnackBarAction(
        label: "dismiss",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
  } catch (e) {
    debugPrint('$e');
  }
}

void showErrorSnackBar(String message, BuildContext context) {
  try {
    final snackDemo = SnackBar(
      content: Text(
        message,
        style: zzRegularWhite15
      ),
      backgroundColor: Colors.red,
      elevation: 10,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      action: SnackBarAction(
        label: "dismiss",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
  } catch (e) {
    debugPrint("$e");
  }
}

/// METHOD FOR MAKING A CALL
void makeCallOrSendMessage(
    String title, String? customerNumber, String aContent) async {
  if (title == 'msg') {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: '+91$customerNumber',
      // path: '$customerNumber',
      queryParameters: <String, String>{
        'body': aContent,
      },
    );
  } else {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '$customerNumber',
    );
  }
}

void sendMessageToWhatsApp(
    String mobile, BuildContext context, String aContent) async {
  var whatsappUrl =
      "whatsapp://send?phone=+91$mobile&text=${Uri.encodeComponent(aContent)}";
  // var whatsappUrl = "https://wa.me/$mobile?text=$aContent";
  try {
    // launch(whatsappUrl);
  } catch (e) {
    //To handle error and display error message
    showErrorSnackBar('Whatsapp Not Installed in the Device', context);
  }
}


String getFormattedStringFromDays(numberOfDays) {
  String aTemp = '';
  var years = (numberOfDays / 365).floor();
  var months = (numberOfDays % 365 / 30).floor();
  var days = (numberOfDays % 365 % 30).floor();
  if (months == 0 && days == 0) {
    if (years == 1) {
      aTemp = "$years Year";
    } else {
      aTemp = "$years Years";
    }
    return aTemp;
  } else {
    if (years == 0) {
      if (years == 0 && months == 0) {
        if (days == 1) {
          aTemp = "$days Day";
        } else {
          aTemp = "$days Days";
        }
        return aTemp;
      } else {
        if (days == 0) {
          aTemp = "$months Month";
          return aTemp;
        } else {
          if (months == 1) {
            if (days == 1) {
              aTemp = "$months Month & $days Day";
            } else {
              aTemp = "$months Month & $days Days";
            }
          } else {
            if (days == 1) {
              aTemp = "$months Months & $days Day";
            } else {
              aTemp = "$months Months & $days Days";
            }
          }
          return aTemp;
        }
      }
    } else {
      if (years == 1) {
        aTemp = "$years Year $months Month & $days Days";
        return aTemp;
      } else {
        if (months == 1) {
          if (days == 1) {
            aTemp = "$years Years $months Month & $days Day";
          } else {
            aTemp = "$years Years $months Month & $days Days";
          }
          return aTemp;
        } else {
          if (days == 1) {
            aTemp = "$years Years $months Months & $days Day";
          } else {
            aTemp = "$years Years $months Months & $days Days";
          }
          return aTemp;
        }
      }
    }
  }
}

String removeDecimalZeroFormat(String n) {
  double a = double.parse(n);
  return a.toStringAsFixed(a.truncateToDouble() == a ? 0 : 2);
}
