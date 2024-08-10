import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart' as geo;

import '../../UI/styles/colors.dart';
import '../abstract/models.dart';
import '../constant.dart';
import '../errors/errors_model.dart';
import '../errors/failures.dart';
import 'lang.dart';
import 'size_config.dart';

DateTime? fromEpoch(int? date) {
  if (date == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(date * 1000);
}

LinearGradient getTrasparenGradient([Color? main]) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      main ?? MyColors.primaryFont.withOpacity(.2),
      Colors.transparent,
    ],
  );
}

BorderRadius getSideIconRadius() {
  return BorderRadius.horizontal(
    left: !Lang.isEn ? Radius.zero : const Radius.circular(20),
    right: Lang.isEn ? Radius.zero : const Radius.circular(20),
  );
}

Future<bool> requestLocationPermission() async {
  Location location = Location();
  bool locationEnabled = await location.serviceEnabled();
  PermissionStatus permission;
  if (!locationEnabled) {
    await location.requestService();
  }
  locationEnabled = await location.serviceEnabled();
  if (locationEnabled) {
    permission = await location.hasPermission();
    switch (permission) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.grantedLimited:
        return true;
      case PermissionStatus.denied:
        permission = await location.requestPermission();
        if (permission == PermissionStatus.granted)
          return true;
        else {
          showToast(message: 'enable_location_permission');
          return false;
        }
      case PermissionStatus.deniedForever:
        showToast(message: 'enable_location_permission');
        return false;
    }
  } else {
    showToast(message: 'turn_on_location');
    return false;
  }
}

Future<geo.Position> determinePosition() async {
  geo.Position position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best);
  return position;
}

String getErrorMessage(Failure error) {
  if (error is ServerFailure) {
    return kServerErrorMessage.tr();
  } else if (error is InternetFailure) {
    return kInternetNotAvailable.tr();
  } else if (error is HttpFailure) {
    if (error.errorModel?.message != null) return error.errorModel!.message!;
    return error.message;
  } else {
    return kSomethingWentWrong.tr();
  }
}

Pair<String, ErrorDictionary> getErrorMessageAndDic(Failure error) {
  if (error is ServerFailure) {
    return Pair(kServerErrorMessage, null);
  } else if (error is InternetFailure) {
    return Pair(kInternetNotAvailable, null);
  } else if (error is HttpFailure) {
    if (error.errorModel != null) {
      return Pair(error.errorModel!.message, error.errorModel!.messageDic);
    }
    return Pair(error.message, null);
  } else {
    return Pair('Unknown error occurred... try again later', null);
  }
}

void plog(dynamic value) => kDebugMode ? Logger().d(value) : null;
void eplog(dynamic value) => kDebugMode ? Logger().e(value) : null;
void wplog(dynamic value) => kDebugMode ? Logger().wtf(value) : null;

TimeOfDay parseStringToTime(String time) =>
    TimeOfDay(hour: int.parse(time.split(':').first), minute: int.parse(time.split(':')[1]));

TimeOfDay? dateToTime(DateTime? date) => date == null ? null : TimeOfDay.fromDateTime(date);

TimeOfDay? parseStringToTimeOr(String? time) =>
    time == null ? null : TimeOfDay(hour: int.parse(time.split(':').first), minute: int.parse(time.split(':')[1]));

double timeToDouble(TimeOfDay? time) {
  if (time == null) return 0;
  return time.hour + time.minute / 60;
}

DateTime? parseDateOr(String? date) => date == null ? null : DateTime.tryParse(date);
DateTime parseDate(String date) => DateTime.parse(date).toLocal();
String? dateToString(DateTime? date) => date?.toUtc().toIso8601String();

String formatDate(DateTime date, [String? pattern]) => DateFormat(
      pattern ?? kMainDateFormat,
      Lang.code,
    ).format(date);
String? formatDateOr(DateTime? date, {String? pattern}) => date == null
    ? null
    : DateFormat(
        pattern ?? kMainDateFormat,
        Lang.code,
      ).format(date);

String getNameTr(String? nameEn, String? nameAr) => (Lang.isEn ? nameEn ?? nameAr : nameAr ?? nameEn) ?? '';

showToast({context, required String message}) {
  Fluttertoast.showToast(msg: message.tr());
}

showErrorToast({context, required String message}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(msg: message.tr());
}

void onPaginate(ScrollController scrollController, VoidCallback call) {
  scrollController.addListener(() {
    // final maxPixel = _scrollController.position.maxScrollExtent;
    // final curr = _scrollController.position.pixels;
    // if ((maxPixel - curr).floor() == 0) cubit.getAttendances();
    if (scrollController.position.extentAfter < 100) call();
  });
}

double getResponsiveWidth(double widgth) {
  return widgth / 375 * SizeConfig.screenWidth;
}

double getResponsiveHeight(double height) {
  return height / 812 * SizeConfig.screenHeight;
}

Future<void> getImageAndUpload(BuildContext context, bool formCamera) async {
  final ImagePicker picker = ImagePicker();
  XFile? imageXFile = await picker.pickImage(source: formCamera ? ImageSource.camera : ImageSource.gallery);

  if (imageXFile != null) {
    File imageFile = File(imageXFile.path);

    // context.read<SettingsCubit>().uploadImage(imageFile);
  }
  // cubit function for upload image
  //  Future<void> uploadImage(File file) async {
  //   emit(const SettingsState.loadingIamge());

  //   final either = await _repo.uploadImage(file);
  //   either.fold(
  //     (error) async {
  //       final pair = getErrorMessageAndDic(error);
  //       emit(SettingsState.error(pair.first ?? ''));
  //     },
  //     (_) =>
  //       emit(const SettingsState.uploadIamge())
  
  //   );
  // }
}

Duration timeSince(DateTime date) {
  return DateTime.now().difference(date);
}

String formattedDuration(Duration duration) {
  String days = duration.inDays == 0 ? "" : "${duration.inDays}";
  String hours = duration.inHours == 0 ? "" : duration.inHours.toString();
  String minutes = duration.inMinutes == 0 ? "" : duration.inMinutes.toString();

  return days.isNotEmpty
      ? "d_ago".tr(args: [days])
      : (hours.isNotEmpty)
          ? "h_ago".tr(args: [hours])
          : minutes.isNotEmpty
              ? "m_ago".tr(args: [minutes])
              : "now".tr();
}
