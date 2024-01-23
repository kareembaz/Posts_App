import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_pages/post_add_update_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_widget/delete_widget.dart';
import 'package:flutter/material.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20.0),
          ),
          const Divider(),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16.0),
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostAddUpdatePage(isUpdatePost: true, post: post),
                      ));
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
              ),
              ElevatedButton.icon(
                // style: ButtonStyle(
                //     // iconColor: MaterialStateProperty.all(Colors.black),
                //     // backgroundColor:
                //     //     MaterialStateProperty.all(Colors.grey[300])
                //     ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteWidget(PostId: post.id!);
                    },
                  );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
