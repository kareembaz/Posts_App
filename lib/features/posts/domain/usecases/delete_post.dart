import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/respositores/post_respositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final PostsRepository repository;

  DeletePostUsecase(this.repository);
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
