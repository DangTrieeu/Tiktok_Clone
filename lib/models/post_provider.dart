import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void setPosts(List<Post> posts) {
    _posts = posts;
    notifyListeners();
  }

  void toggleLike(int index) {
    final post = _posts[index];
    post.isLiked = !post.isLiked;
    post.isLiked ? post.likeCount++ : post.likeCount--;
    notifyListeners();
  }

  void addComment(int index, String comment) {
    _posts[index].commentCount++;
    notifyListeners();
  }
}
