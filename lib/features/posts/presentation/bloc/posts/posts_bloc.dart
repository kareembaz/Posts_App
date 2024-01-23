import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures_String.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entites/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/post_states.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:dartz/dartz.dart';

class PostBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(mapFailurOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts();
        emit(mapFailurOrPostsToState(failureOrPosts));
      }
    });
  }
  PostsState mapFailurOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(error: mapFailureToMessage(failure)),
      (posts) => SucessPostsState(posts: posts),
    );
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCachFailure:
        return Empty_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , Please Try again later ...';
    }
  }
}
