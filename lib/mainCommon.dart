import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopme_mobile/data/local/shared_preferences/shared_pref.dart';
import 'package:shopme_mobile/pages/application/aplication.dart';

import 'core/common/constants/localization_constant.dart';
import 'di/injection.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
    SharedPref.ensureInitialized(),
  ]);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: LocalizationConstant.defaultLanguage,
      supportedLocales: LocalizationConstant.supportedLanguages,
      useOnlyLangCode: true,
      child: Application(),
    ),
  );
}
