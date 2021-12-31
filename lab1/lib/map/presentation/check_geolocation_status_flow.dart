import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _alertTitle =
    'Разрешить приложению «Бристоль» определять вашу геопозицию';
const String _alertContent =
    'Бристоль нужно знать ваше местоположение, чтобы сделать доступным поиск ближайших от вас магазинов и улучшить результаты поиска. Для этого вам необходимо внести изменения в настройках телефона.';
const String _alertOkTitle = 'Перейти в настройки';
const String _alertDenyTitle = 'Не разрешать';

Future<void> startCheckLocationFlow(
  BuildContext context, {
  required GeolocationService geoService,
}) async {
  final status = await locator
      .get<GeolocationService>()
      .checkGeolocationPermissionStatus();

  ///ios flow
  if (Platform.isIOS) {
    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      return;
    }

    ///ожидаем вызов пермишена
    if (status != LocationPermission.deniedForever) {
      await geoService.requestPermission().then((value) async {
        if (value == LocationPermission.deniedForever) {
          _denyGeoFlow(context);
          return;
        }
        if (value == LocationPermission.whileInUse ||
            value == LocationPermission.always) {
          await _setRemoteLocation();
        }
      });
    }

    ///отправляем в настройки
    if (status == LocationPermission.deniedForever) {
      await _showSettingsDialog(context);
    }
  }

  ///android flow
  if (Platform.isAndroid) {
    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      return;
    }

    ///пытаемся вызвать пермишен
    ///checkStatus возвращает denied, а requestPermission - deniedForever :)
    if (status == LocationPermission.denied) {
      await geoService.requestPermission().then((value) async {
        if (value == LocationPermission.denied) {
          _denyGeoFlow(context);
          return;
        }
        if (value == LocationPermission.deniedForever) {
          await _showSettingsDialog(context);
          return;
        }
        if (value == LocationPermission.always ||
            value == LocationPermission.whileInUse) {
          await _setRemoteLocation();
        }
      });
      if (status == LocationPermission.deniedForever) {
        await _showSettingsDialog(context);
      }
    }
  }
}

Future<T?> _showSettingsDialog<T>(BuildContext context) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) => CupertinoAlertDialog(
        insetAnimationDuration: const Duration(milliseconds: 500),
        title: const Text(_alertTitle),
        content: const Text(_alertContent),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              _alertOkTitle,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            onPressed: () => _startSettingsFlow(context),
          ),
          CupertinoDialogAction(
            child: const Text(_alertDenyTitle),
            onPressed: () {
              _denyGeoFlow(context);
            },
          ),
        ],
      ),
    );
  } else {
    final textTheme = Theme.of(context).textTheme;

    /// подходящего стиля в теме не было
    const buttonTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: BristolColors.androidButtonColor,
    );
    final buttonStyle = ButtonStyle(
      overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12),
    );
    return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_alertTitle, style: textTheme.headline6),
        content: Text(_alertContent, style: textTheme.bodyText1),
        actions: [
          TextButton(
            onPressed: () => _startSettingsFlow(context),
            child: const Text(_alertOkTitle, style: buttonTextStyle),
            style: buttonStyle,
          ),
          TextButton(
            onPressed: () {
              _denyGeoFlow(context);
            },
            child: const Text(_alertDenyTitle, style: buttonTextStyle),
            style: buttonStyle,
          )
        ],
      ),
    );
  }
}

void _denyGeoFlow(BuildContext context) {
  final location = locator.get<AppStore>().state.location;
  if (location?.city != null && location?.region != null) {
    navigatorPop(context);
  } else {
    _startLocationPlayFlow(context);
  }
}

void _startSettingsFlow(BuildContext context) {
  navigatorPop(context);
  Geolocator.openLocationSettings();
}

Future<void> _setRemoteLocation() async {
  final position = await locator.get<GeolocationService>().getLastPosition();
  if (position != null) {
    await locator
        .get<LocationsRepository>()
        .fetchLocation(position)
        .then((value) async {
      if (value != null) {
        await locator.get<AppStore>().pickLocation(value);
      }
    });
  }
}

void _startLocationPlayFlow(BuildContext context) {
  navigatorPushAndRemoveUntil(
    context,
    RegionOnBoarding(),
  );
}
