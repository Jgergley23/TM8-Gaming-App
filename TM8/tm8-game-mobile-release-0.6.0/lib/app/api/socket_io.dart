import 'package:loggy/loggy.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';

class SocketInitialized {
  late Socket socket;
  void initSocket() {
    final accessToken = sl<Tm8Storage>().accessToken;

    if (accessToken != '') {
      socket = io(
        'https://test.api.tm8gaming.com',
        OptionBuilder().setExtraHeaders(
          {"Authorization": "Bearer $accessToken"},
        ).setTransports(['websocket']).build(),
      );

      socket.onConnect((_) {
        logInfo('Socket connected');
        socket.emit('msg', 'test');
      });
      socket.onDisconnect((_) {
        logInfo('Disconnected');
      });
      socket.on('event', (data) => logInfo(data));
      socket.connect();
    } else {
      logInfo('accessToken is empty');
    }
  }

  void disconnect() {
    try {
      socket.disconnect();
    } catch (e) {
      logError('Error disconnecting socket: $e');
    }
  }
}
