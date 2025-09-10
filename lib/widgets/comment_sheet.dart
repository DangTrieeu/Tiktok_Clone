import 'package:flutter/material.dart';

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  // Dữ liệu mẫu cho bình luận
  final List<Map<String, String>> comments = [
    {
      'name': 'Nguyễn Văn A',
      'avatar': '', // Để trống, sẽ dùng avatar mặc định
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("3400 Comments", style: TextStyle(fontSize: 15)),
        centerTitle: true,
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar bên trái
                  CircleAvatar(
                    radius: 20,
                    child: Text(comment['name']![0]),
                  ),
                  SizedBox(width: 10),
                  // Nội dung bên phải
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(comment['content']!),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up_alt_outlined, size: 20),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_down_alt_outlined, size: 20),
                        onPressed: () {},
                      ),
                    ],
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
                  // Xử lý gửi bình luận mới
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
