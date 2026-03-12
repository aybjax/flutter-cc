class SaveUserSettingsParams {
  const SaveUserSettingsParams({
    required this.displayName,
    required this.signalingUrl,
    required this.startWithVideo,
  });

  final String displayName;
  final String signalingUrl;
  final bool startWithVideo;
}
