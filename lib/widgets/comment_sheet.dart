import 'package:flutter/material.dart';

class CommentSheet extends StatefulWidget {
  final int postIndex;
  final int commentCount;
  final ValueChanged<String>? onAddComment;
  const CommentSheet({super.key, required this.postIndex, required this.commentCount, this.onAddComment});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final List<Map<String, String>> comments = [
    {
      'name': 'Nguyễn Văn A',
      'avatar': '',
      'content': 'Video rất hay, cảm ơn bạn!'
    },
    {
      'name': 'Trần Thị B',
      'avatar': '',
      'content': 'Văn bản là một loại hình phương tiện để ghi nhận, lưu giữ và truyền đạt các thông tin từ chủ thể này sang chủ thể khác bằng ký hiệu gọi là chữ viết. Nó gồm tập hợp các câu có tính trọn vẹn về nội dung, hoàn chỉnh về hình thức, có tính liên kết chặt chẽ và hướng tới một mục tiêu giao tiếp nhất định.[1][2][3][4] Hay nói khác đi, văn bản là một dạng sản phẩm của hoạt động giao tiếp bằng ngôn ngữ được thể hiện ở dạng viết trên một chất liệu nào đó (giấy, bia đá,...). Văn bản bao gồm các tài liệu, tư liệu, giấy tờ có giá trị pháp lý nhất định, được sử dụng trong hoạt động của các cơ quan Nhà nước, các tổ chức chính trị, chính trị - xã hội, các tổ chức kinh tế... như: các văn bản pháp luật, các công văn, tài liệu, giấy tờ.'
    },
    {
      'name': 'Lê Văn C',
      'avatar': '',
      'content': 'Có thể làm thêm về chủ đề này không?'
    },
  ];

  final TextEditingController _controller = TextEditingController();
  late List<bool> expandedComments;

  @override
  void initState() {
    super.initState();
    expandedComments = List.generate(comments.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.commentCount} Comments", style: TextStyle(fontSize: 15)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            final isExpanded = expandedComments[index];
            final content = comment['content']!;
            final maxLength = 120;
            final showExpand = content.length > maxLength;
            final displayContent =
                !showExpand || isExpanded ? content : content.substring(0, maxLength) + '...';
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Text(comment['name']![0]),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(displayContent),
                        if (showExpand && !isExpanded)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                expandedComments[index] = true;
                              });
                            },
                            child: Text(
                              'Hiện thêm',
                              style: TextStyle(color: Colors.blue, fontSize: 13),
                            ),
                          ),
                        Row(
                          children: [
                            Text(
                              '1 giờ trước',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Phản hồi',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up_alt_outlined, size: 20),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                            ),
                            IconButton(
                              icon: Icon(Icons.thumb_down_alt_outlined, size: 20),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập bình luận...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    widget.onAddComment?.call(_controller.text.trim());
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
