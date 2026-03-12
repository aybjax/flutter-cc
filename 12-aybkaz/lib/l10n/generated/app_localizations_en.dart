// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PeerLink';

  @override
  String get homeTitle => '1x1 calls without extra ceremony';

  @override
  String get homeSubtitle =>
      'Save your profile, check the signaling server, then jump into a direct call with a compact chat.';

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
  String get checkServerAction => 'Check server';

  @override
  String get joinCallAction => 'Join call';

  @override
  String get serverOnline => 'Server is reachable';

  @override
  String get serverOffline => 'Server did not respond';

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
