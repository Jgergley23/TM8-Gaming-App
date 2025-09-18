import 'package:stream_chat/stream_chat.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart' as video;
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/env/env.dart';

// get stream client setup for both calls and messages
final client = StreamChatClient(
  Env.streamKey,
  logLevel: Level.INFO,
);

final clientVideo = video.StreamVideo(
  Env.streamKey,
  user: video.User(info: video.UserInfo(id: sl<Tm8Storage>().userId)),
  userToken: sl<Tm8Storage>().chatToken,
  options: const video.StreamVideoOptions(
    logPriority: video.Priority.info,
  ),
);
