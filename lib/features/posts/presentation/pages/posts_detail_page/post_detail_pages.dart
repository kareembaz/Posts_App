import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_widget/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text('Post Detail'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      )),
    );
  }
}
