String normalizeSocketUrl(String input) {
  final trimmed = input.trim();

  if (trimmed.isEmpty) {
    return trimmed;
  }

  if (trimmed.startsWith('ws://') || trimmed.startsWith('wss://')) {
    return trimmed;
  }

  if (trimmed.startsWith('http://')) {
    return trimmed.replaceFirst('http://', 'ws://');
  }

  if (trimmed.startsWith('https://')) {
    return trimmed.replaceFirst('https://', 'wss://');
  }

  return 'ws://$trimmed';
}

String toProbeHttpUrl(String input) {
  final normalized = normalizeSocketUrl(input);

  if (normalized.startsWith('ws://')) {
    return normalized.replaceFirst('ws://', 'http://');
  }

  if (normalized.startsWith('wss://')) {
    return normalized.replaceFirst('wss://', 'https://');
  }

  return normalized;
}
