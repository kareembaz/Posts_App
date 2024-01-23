import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:equatable/equatable.dart';

abstract class AddUpdataDeletePostEvent extends Equatable {
  const AddUpdataDeletePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdataDeletePostEvent {
  final Post post;

  AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class updataPostEvent extends AddUpdataDeletePostEvent {
  final Post post;

  updataPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class deletePostEvent extends AddUpdataDeletePostEvent {
  final int postId;
  deletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
