class Post {
  final String id;
  final String videoUrl;
  final String user;
  final String caption;
  int likeCount;
  int commentCount;
  bool isLiked;

  Post({
    required this.id,
    required this.videoUrl,
    required this.user,
    required this.caption,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
  });
}

