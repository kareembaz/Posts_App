import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_detail_page/post_detail_pages.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key, required this.posts});
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(
                posts[index].id.toString(),
                style: TextStyle(fontSize: 15.0),
              ),
              title: Text(
                posts[index].title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                posts[index].body,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: posts[index]),
                    ));
                print(posts[index]);
                print(posts[index].title);
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: posts.length),
    );
  }
}
