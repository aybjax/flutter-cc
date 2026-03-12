import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/utils/url_utils.dart';
import '../dtos/signaling_message_dto.dart';

class CallRoomSignalingDataSource {
  final StreamController<SignalingMessageDto> _controller =
      StreamController<SignalingMessageDto>.broadcast();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  Stream<SignalingMessageDto> get messages => _controller.stream;

  Future<void> connect(String signalingUrl) async {
    await disconnect();

    final uri = Uri.parse(normalizeSocketUrl(signalingUrl));
    _channel = WebSocketChannel.connect(uri);
    _subscription = _channel!.stream.listen(
      (dynamic event) {
        if (event is String) {
          _controller.add(
            SignalingMessageDto.fromJson(
              jsonDecode(event) as Map<String, dynamic>,
            ),
          );
        }
      },
      onError: _controller.addError,
      onDone: () {
        _controller.add(const SignalingMessageDto(type: 'socket-closed'));
      },
    );
  }

  Future<void> send(SignalingMessageDto message) async {
    final channel = _channel;
    if (channel == null) {
      throw StateError('WebSocket connection is not established.');
    }

    channel.sink.add(jsonEncode(message.toJson()));
  }

  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;
    await _channel?.sink.close();
    _channel = null;
  }
}
