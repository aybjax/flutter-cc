import '../../../../core/network/app_dio_client.dart';
import '../../../../core/utils/url_utils.dart';

abstract class ServerProbeRemoteDataSource {
  Future<bool> probe(String signalingUrl);
}

class ServerProbeRemoteDataSourceImpl implements ServerProbeRemoteDataSource {
  const ServerProbeRemoteDataSourceImpl(this._dioClient);

  final AppDioClient _dioClient;

  @override
  Future<bool> probe(String signalingUrl) {
    return _dioClient.probeServer(toProbeHttpUrl(signalingUrl));
  }
}
