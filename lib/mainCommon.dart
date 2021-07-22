import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shopme_mobile/pages/application/aplication.dart';

import 'core/common/constants/localization_constant.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
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
