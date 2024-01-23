import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_add_update_widget/fromtext_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FromWidget extends StatefulWidget {
  const FromWidget({super.key, required this.isUpdatePost, this.post});
  final bool isUpdatePost;
  final Post? post;
  @override
  State<FromWidget> createState() => _FromWidgetState();
}

class _FromWidgetState extends State<FromWidget> {
  final formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void ValidateFormThenUpdateOrAddPost() {
    final isVaild = formKey.currentState!.validate();
    if (isVaild) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: titleController.text,
          body: bodyController.text);
      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdataDeletePostBloc>(context)
            .add(updataPostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdataDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFromWidget(
                    bodyControll: titleController,
                    text: "Title",
                    minline: 1,
                    maxline: 1)),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFromWidget(
                  bodyControll: bodyController,
                  text: "Body",
                  minline: 6,
                  maxline: 16,
                )),
            ElevatedButton.icon(
              onPressed: ValidateFormThenUpdateOrAddPost,
              icon: widget.isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
              label: Text(widget.isUpdatePost ? "Update" : "Add"),
            ),
          ],
        ),
      ),
    );
  }
}
