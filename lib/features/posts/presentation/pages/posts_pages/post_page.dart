import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/post_states.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_pages/post_add_update_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/page_list_widget/message_display_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/page_list_widget/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
            child: Text(
          'Posts',
        )),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return LoadingWidget();
            } else if (state is SucessPostsState) {
              return RefreshIndicator(
                onRefresh: () => onRefresh(context),
                child: PostListWidget(posts: state.posts),
              );
            } else if (state is ErrorPostsState) {
              String message = state.error;
              return MessageDisplayWidget(message: message);
            }
            return LoadingWidget();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PostAddUpdatePage(isUpdatePost: false),
              ));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  Future<void> onRefresh(context) async {
    BlocProvider.of<PostBloc>(context).add(RefreshPostsEvent());
  }
}
