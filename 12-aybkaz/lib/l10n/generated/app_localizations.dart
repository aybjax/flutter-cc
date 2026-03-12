import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VideoCall'**
  String get appTitle;

  /// No description provided for @messagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'1x1 calls without extra ceremony'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your profile, check the signaling server, then jump into a direct call with a compact chat.'**
  String get homeSubtitle;

  /// No description provided for @searchConversationsHint.
  ///
  /// In en, this message translates to:
  /// **'Search contacts or meetings...'**
  String get searchConversationsHint;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @recentCallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent calls'**
  String get recentCallsTitle;

  /// No description provided for @displayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayNameLabel;

  /// No description provided for @displayNameHint.
  ///
  /// In en, this message translates to:
  /// **'How the other side will see you'**
  String get displayNameHint;

  /// No description provided for @serverUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Signaling server URL'**
  String get serverUrlLabel;

  /// No description provided for @serverUrlHint.
  ///
  /// In en, this message translates to:
  /// **'ws://localhost:3000'**
  String get serverUrlHint;

  /// No description provided for @serverUrlHelper.
  ///
  /// In en, this message translates to:
  /// **'For a real phone use your laptop LAN IP. Android emulator usually needs ws://10.0.2.2:3000.'**
  String get serverUrlHelper;

  /// No description provided for @startWithVideoLabel.
  ///
  /// In en, this message translates to:
  /// **'Start with camera enabled'**
  String get startWithVideoLabel;

  /// No description provided for @settingsSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Call setup'**
  String get settingsSheetTitle;

  /// No description provided for @settingsSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your display name, signaling URL and launch preferences before joining.'**
  String get settingsSheetSubtitle;

  /// No description provided for @checkServerAction.
  ///
  /// In en, this message translates to:
  /// **'Check server'**
  String get checkServerAction;

  /// No description provided for @joinCallAction.
  ///
  /// In en, this message translates to:
  /// **'Join call'**
  String get joinCallAction;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @startVideoCallCta.
  ///
  /// In en, this message translates to:
  /// **'Start video call'**
  String get startVideoCallCta;

  /// No description provided for @serverOnline.
  ///
  /// In en, this message translates to:
  /// **'Server is reachable'**
  String get serverOnline;

  /// No description provided for @serverOffline.
  ///
  /// In en, this message translates to:
  /// **'Server did not respond'**
  String get serverOffline;

  /// No description provided for @serverStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Server not checked'**
  String get serverStatusUnknown;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get saveSuccess;

  /// No description provided for @validationDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Enter a display name'**
  String get validationDisplayName;

  /// No description provided for @validationServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter a signaling server URL'**
  String get validationServerUrl;

  /// No description provided for @howItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'Backend'**
  String get howItWorksTitle;

  /// No description provided for @howItWorksBody.
  ///
  /// In en, this message translates to:
  /// **'The current app is wired for the lightweight Node signaling server in webrtc-test/2clients. You can swap the URL later without changing the UI.'**
  String get howItWorksBody;

  /// No description provided for @callTitle.
  ///
  /// In en, this message translates to:
  /// **'Call room'**
  String get callTitle;

  /// No description provided for @callSubtitleWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the second participant'**
  String get callSubtitleWaiting;

  /// No description provided for @callSubtitleConnecting.
  ///
  /// In en, this message translates to:
  /// **'Preparing media and signaling'**
  String get callSubtitleConnecting;

  /// No description provided for @callSubtitleNegotiating.
  ///
  /// In en, this message translates to:
  /// **'Negotiating peer connection'**
  String get callSubtitleNegotiating;

  /// No description provided for @callSubtitleInCall.
  ///
  /// In en, this message translates to:
  /// **'Call is live'**
  String get callSubtitleInCall;

  /// No description provided for @callSubtitleDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Peer disconnected'**
  String get callSubtitleDisconnected;

  /// No description provided for @callSubtitleRoomFull.
  ///
  /// In en, this message translates to:
  /// **'Room is already full'**
  String get callSubtitleRoomFull;

  /// No description provided for @callSubtitleFailure.
  ///
  /// In en, this message translates to:
  /// **'Call setup failed'**
  String get callSubtitleFailure;

  /// No description provided for @localVideoLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get localVideoLabel;

  /// No description provided for @remoteVideoLabel.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get remoteVideoLabel;

  /// No description provided for @videoOffLabel.
  ///
  /// In en, this message translates to:
  /// **'Camera off'**
  String get videoOffLabel;

  /// No description provided for @waitingPeerLabel.
  ///
  /// In en, this message translates to:
  /// **'Waiting for another participant to join'**
  String get waitingPeerLabel;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatTitle;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get chatHint;

  /// No description provided for @sendAction.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendAction;

  /// No description provided for @shareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAction;

  /// No description provided for @filtersAction.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersAction;

  /// No description provided for @chatAction.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatAction;

  /// No description provided for @detailsAction.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsAction;

  /// No description provided for @muteAction.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get muteAction;

  /// No description provided for @unmuteAction.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get unmuteAction;

  /// No description provided for @cameraOffAction.
  ///
  /// In en, this message translates to:
  /// **'Camera off'**
  String get cameraOffAction;

  /// No description provided for @cameraOnAction.
  ///
  /// In en, this message translates to:
  /// **'Camera on'**
  String get cameraOnAction;

  /// No description provided for @leaveAction.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leaveAction;

  /// No description provided for @copyPeerIdSuccess.
  ///
  /// In en, this message translates to:
  /// **'Peer ID copied'**
  String get copyPeerIdSuccess;

  /// No description provided for @callFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Video filters'**
  String get callFiltersTitle;

  /// No description provided for @applyFilterAction.
  ///
  /// In en, this message translates to:
  /// **'Apply filter'**
  String get applyFilterAction;

  /// No description provided for @filterNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get filterNone;

  /// No description provided for @filterBlur.
  ///
  /// In en, this message translates to:
  /// **'Blur'**
  String get filterBlur;

  /// No description provided for @filterMono.
  ///
  /// In en, this message translates to:
  /// **'Mono'**
  String get filterMono;

  /// No description provided for @filterWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get filterWarm;

  /// No description provided for @systemSender.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemSender;

  /// No description provided for @emptyChat.
  ///
  /// In en, this message translates to:
  /// **'Messages will appear here during the call.'**
  String get emptyChat;

  /// No description provided for @backAction.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @peerLeftMessage.
  ///
  /// In en, this message translates to:
  /// **'The other participant left the call.'**
  String get peerLeftMessage;

  /// No description provided for @callEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Type something before sending.'**
  String get callEmptyMessage;

  /// No description provided for @callNoSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings could not be loaded.'**
  String get callNoSettings;

  /// No description provided for @incomingStatus.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get incomingStatus;

  /// No description provided for @outgoingStatus.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoingStatus;

  /// No description provided for @missedStatus.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missedStatus;

  /// No description provided for @chatsTab.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chatsTab;

  /// No description provided for @peopleTab.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get peopleTab;

  /// No description provided for @callsTab.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get callsTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @statusIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle'**
  String get statusIdle;

  /// No description provided for @statusConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting'**
  String get statusConnecting;

  /// No description provided for @statusWaitingPeer.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get statusWaitingPeer;

  /// No description provided for @statusNegotiating.
  ///
  /// In en, this message translates to:
  /// **'Negotiating'**
  String get statusNegotiating;

  /// No description provided for @statusInCall.
  ///
  /// In en, this message translates to:
  /// **'In call'**
  String get statusInCall;

  /// No description provided for @statusDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get statusDisconnected;

  /// No description provided for @statusRoomFull.
  ///
  /// In en, this message translates to:
  /// **'Room full'**
  String get statusRoomFull;

  /// No description provided for @statusFailure.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get statusFailure;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
