// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VideoCall';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get peopleTitle => 'People';

  @override
  String get callsTitle => 'Calls';

  @override
  String get homeTitle => '1x1 calls without extra ceremony';

  @override
  String get homeSubtitle =>
      'Save your profile, check the signaling server, then jump into a direct call with a compact chat.';

  @override
  String get peopleSubtitle =>
      'Favorites stay on top, while the full contact list lives below.';

  @override
  String get callsSubtitle =>
      'Recent incoming, outgoing and missed calls in one place.';

  @override
  String get searchConversationsHint => 'Search contacts or meetings...';

  @override
  String get searchPeopleHint => 'Search people...';

  @override
  String get searchCallsHint => 'Search recent calls...';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get allPeopleTitle => 'All people';

  @override
  String get conversationsTitle => 'Recent chats';

  @override
  String get recentCallsTitle => 'Recent calls';

  @override
  String get serverPrepTitle => 'Before server connection';

  @override
  String get serverPrepBody =>
      'Check the signaling server first, then start the call from the floating button.';

  @override
  String get openSetupAction => 'Open setup';

  @override
  String get onlineLabel => 'Online';

  @override
  String get offlineLabel => 'Offline';

  @override
  String get unreadLabel => 'Unread';

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get displayNameHint => 'How the other side will see you';

  @override
  String get serverUrlLabel => 'Signaling server URL';

  @override
  String get serverUrlHint => 'ws://localhost:3000';

  @override
  String get serverUrlHelper =>
      'For a real phone use your laptop LAN IP. Android emulator usually needs ws://10.0.2.2:3000.';

  @override
  String get startWithVideoLabel => 'Start with camera enabled';

  @override
  String get settingsSheetTitle => 'Call setup';

  @override
  String get settingsSheetSubtitle =>
      'Update your display name, signaling URL and launch preferences before joining.';

  @override
  String get checkServerAction => 'Check server';

  @override
  String get joinCallAction => 'Join call';

  @override
  String get saveAction => 'Save';

  @override
  String get startVideoCallCta => 'Start video call';

  @override
  String get serverOnline => 'Server is reachable';

  @override
  String get serverOffline => 'Server did not respond';

  @override
  String get serverStatusUnknown => 'Server not checked';

  @override
  String get saveSuccess => 'Settings saved';

  @override
  String get validationDisplayName => 'Enter a display name';

  @override
  String get validationServerUrl => 'Enter a signaling server URL';

  @override
  String get howItWorksTitle => 'Backend';

  @override
  String get howItWorksBody =>
      'The current app is wired for the lightweight Node signaling server in webrtc-test/2clients. You can swap the URL later without changing the UI.';

  @override
  String get callTitle => 'Call room';

  @override
  String get callSubtitleWaiting => 'Waiting for the second participant';

  @override
  String get callSubtitleConnecting => 'Preparing media and signaling';

  @override
  String get callSubtitleNegotiating => 'Negotiating peer connection';

  @override
  String get callSubtitleInCall => 'Call is live';

  @override
  String get callSubtitleDisconnected => 'Peer disconnected';

  @override
  String get callSubtitleRoomFull => 'Room is already full';

  @override
  String get callSubtitleFailure => 'Call setup failed';

  @override
  String get localVideoLabel => 'You';

  @override
  String get remoteVideoLabel => 'Remote';

  @override
  String get videoOffLabel => 'Camera off';

  @override
  String get waitingPeerLabel => 'Waiting for another participant to join';

  @override
  String get chatTitle => 'Chat';

  @override
  String get chatHint => 'Write a message';

  @override
  String get sendAction => 'Send';

  @override
  String get shareAction => 'Share';

  @override
  String get filtersAction => 'Filters';

  @override
  String get chatAction => 'Chat';

  @override
  String get detailsAction => 'Details';

  @override
  String get muteAction => 'Mute';

  @override
  String get unmuteAction => 'Unmute';

  @override
  String get cameraOffAction => 'Camera off';

  @override
  String get cameraOnAction => 'Camera on';

  @override
  String get leaveAction => 'Leave';

  @override
  String get copyPeerIdSuccess => 'Peer ID copied';

  @override
  String get callFiltersTitle => 'Video filters';

  @override
  String get applyFilterAction => 'Apply filter';

  @override
  String get filterNone => 'None';

  @override
  String get filterBlur => 'Blur';

  @override
  String get filterMono => 'Mono';

  @override
  String get filterWarm => 'Warm';

  @override
  String get systemSender => 'System';

  @override
  String get emptyChat => 'Messages will appear here during the call.';

  @override
  String get backAction => 'Back';

  @override
  String get retryAction => 'Retry';

  @override
  String get peerLeftMessage => 'The other participant left the call.';

  @override
  String get callEmptyMessage => 'Type something before sending.';

  @override
  String get callNoSettings => 'Settings could not be loaded.';

  @override
  String get incomingStatus => 'Incoming';

  @override
  String get outgoingStatus => 'Outgoing';

  @override
  String get missedStatus => 'Missed';

  @override
  String get chatsTab => 'Chats';

  @override
  String get peopleTab => 'People';

  @override
  String get callsTab => 'Calls';

  @override
  String get settingsTab => 'Settings';

  @override
  String get statusIdle => 'Idle';

  @override
  String get statusConnecting => 'Connecting';

  @override
  String get statusWaitingPeer => 'Waiting';

  @override
  String get statusNegotiating => 'Negotiating';

  @override
  String get statusInCall => 'In call';

  @override
  String get statusDisconnected => 'Disconnected';

  @override
  String get statusRoomFull => 'Room full';

  @override
  String get statusFailure => 'Error';
}
