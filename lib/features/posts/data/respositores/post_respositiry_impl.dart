import 'package:clean_architecture_posts_app/core/msg_fail_ex/exeptions.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/core/network/network.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/model/post_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/respositores/post_respositories.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> itemsOfFunctionType();

class PostsRespositoryImpl implements PostsRepository {
  final PostRemotedataSouce remotedataSouce;
  final PostLocalDataSource localDataSource;
  final NetworkInfoImpl networkInfoImpl;
  PostsRespositoryImpl({
    required this.remotedataSouce,
    required this.localDataSource,
    required this.networkInfoImpl,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfoImpl.isConnected) {
      //if   the decive connect th internet
      try {
        final remotePosts = await remotedataSouce.getAllPosts();
        localDataSource.cachedPosts(remotePosts);
        return Right(remotePosts);
      } on ServerExecptoion {
        return Left(ServerFailure());
      }
    } else {
      //if   the decive   disconnect th internet
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheExecptoion {
        return Left(EmptyCachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await itemsOfFunction(() {
      return remotedataSouce.addPost(postModel);
    });

    // if (await networkInfoImpl.isConnected) {
    //   //if   the decive connect th internet
    //   try {
    //     await remotedataSouce.addPost(postModel);
    //     return Right(unit);
    //   } on ServerExecptoion {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return left(OfflineFailure());
    // }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await itemsOfFunction(() {
      return remotedataSouce.deletePost(postId);
    });

    // if (await networkInfoImpl.isConnected) {
    //   //if   the decive connect th internet
    //   try {
    //     await remotedataSouce.deletePost(postId);
    //     return Right(unit);
    //   } on ServerExecptoion {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return left(OfflineFailure());
    // }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await itemsOfFunction(() {
      return remotedataSouce.updatePost(postModel);
    });
    // if (await networkInfoImpl.isConnected) {
    //   //if   the decive connect th internet
    //   try {
    //     await remotedataSouce.updatePost(postModel);
    //     return Right(unit);
    //   } on ServerExecptoion {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return left(OfflineFailure());
    // }
  }

  Future<Either<Failure, Unit>> itemsOfFunction(
      itemsOfFunctionType deleteOrupDateOraddPost) async {
    {
      if (await networkInfoImpl.isConnected) {
        //if   the decive connect th internet
        try {
          await deleteOrupDateOraddPost();
          return Right(unit);
        } on ServerExecptoion {
          return Left(ServerFailure());
        }
      } else {
        return left(OfflineFailure());
      }
    }
  }
}
