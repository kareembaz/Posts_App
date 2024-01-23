import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/respositores/post_respositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
