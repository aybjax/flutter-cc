import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
abstract class AppFailure with _$AppFailure {
  const factory AppFailure.network({
    @Default('Network error.') String message,
  }) = NetworkAppFailure;

  const factory AppFailure.server({@Default('Server error.') String message}) =
      ServerAppFailure;

  const factory AppFailure.cache({@Default('Cache error.') String message}) =
      CacheAppFailure;

  const factory AppFailure.validation({
    @Default('Validation error.') String message,
  }) = ValidationAppFailure;

  const factory AppFailure.webrtc({
    @Default('Call setup error.') String message,
  }) = WebRtcAppFailure;

  const factory AppFailure.unknown({
    @Default('Unexpected error.') String message,
  }) = UnknownAppFailure;
}
