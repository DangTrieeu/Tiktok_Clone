import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int initialCount;
  final bool isLiked;                // <-- thêm đây
  final ValueChanged<bool>? onChanged;

  const LikeButton({
    Key? key,
    this.initialCount = 0,
    this.isLiked = false,            // <-- tham số mặc định
    this.onChanged,
  }) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;            // khởi tạo từ widget.isLiked
    _likeCount = widget.initialCount;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount--;
      } else {
        _isLiked = true;
        _likeCount++;
      }
    });

    if (widget.onChanged != null) widget.onChanged!(_isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _toggleLike,
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.red : Colors.white,
            size: 32,
          ),
        ),
        Text(
          '$_likeCount',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
