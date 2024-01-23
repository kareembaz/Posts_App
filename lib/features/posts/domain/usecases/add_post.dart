import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/respositores/post_respositories.dart';
import 'package:dartz/dartz.dart';

class AddPostUsecase {
  final PostsRepository repository;

  AddPostUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
