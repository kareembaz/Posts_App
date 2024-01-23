import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/snakbar_message.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_states.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({super.key, required this.PostId});
  final int PostId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUpdataDeletePostBloc, AddUpdataDeletePostStates>(
      listener: (context, state) {
        if (state is SuccessAddUpdataDeletePostState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => PostsPage(),
              ),
              (route) => false);
        } else if (state is ErrorAddUpdataDeletePostState) {
          Navigator.pop(context);
          SnackBarMessage()
              .showErrorSnackBar(message: state.error, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAddUpdataDeletePostState) {
          return AlertDialog(
            title: LoadingWidget(),
          );
        }
        return AlertDialog(
          title: Text('Are you Sure ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AddUpdataDeletePostBloc>(context)
                    .add(deletePostEvent(postId: PostId));
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
