import 'package:pva/feature/library%20/domain/entities/video_info.dart';
import 'package:pva/feature/library%20/presentation/widget/author_type.dart';

class Resource {
  final String title;
  final String desc;
  final String author;
  final ResourceType documentType;
  final VideoInfo? videoInfo;

  Resource(
      {required this.title,
      required this.desc,
      required this.author,
      required this.documentType,
      this.videoInfo
      });
}

enum ResourceType {
  article,
  video
}