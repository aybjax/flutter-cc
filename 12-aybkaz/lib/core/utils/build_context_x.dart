import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get S => AppLocalizations.of(this);
}
