import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class SucessPostsState extends PostsState {
  final List<Post> posts;

  SucessPostsState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String error;

  ErrorPostsState({required this.error});

  @override
  List<Object?> get props => [error];
}
