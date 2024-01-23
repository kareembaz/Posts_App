import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/snakbar_message.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_states.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_pages/from_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  const PostAddUpdatePage({super.key, required this.isUpdatePost, this.post});
  final Post? post;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(isUpdatePost ? 'Update Post' : 'Add Post'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child:
              BlocConsumer<AddUpdataDeletePostBloc, AddUpdataDeletePostStates>(
            listener: (context, state) {
              if (state is SuccessAddUpdataDeletePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorAddUpdataDeletePostState) {
                SnackBarMessage()
                    .showErrorSnackBar(message: state.error, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdataDeletePostState) {
                return LoadingWidget();
              }
              return FromWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          ),
        ),
      ),
    );
  }
}
