import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/failures_String.dart';
import 'package:clean_architecture_posts_app/core/msg_fail_ex/messgae_success.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_states.dart';
import 'package:dartz/dartz.dart';

class AddUpdataDeletePostBloc
    extends Bloc<AddUpdataDeletePostEvent, AddUpdataDeletePostStates> {
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;

  AddUpdataDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdataDeletePostInitial()) {
    on<AddUpdataDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdataDeletePostState());
        final failureOrDoneMessage = await addPost.call(event.post);
        emit(
            mapFailurOrPostsToState(failureOrDoneMessage, ADD_SUCCESS_MEESAGE));
      } else if (event is updataPostEvent) {
        emit(LoadingAddUpdataDeletePostState());
        final failureOrDoneMessage = await updatePost.call(event.post);
        emit(mapFailurOrPostsToState(
            failureOrDoneMessage, Update_SUCCESS_MEESAGE));
      } else if (event is deletePostEvent) {
        emit(LoadingAddUpdataDeletePostState());
        final failureOrDoneMessage = await deletePost.call(event.postId);
        emit(mapFailurOrPostsToState(
            failureOrDoneMessage, Delete_SUCCESS_MEESAGE));
      }
    });
  }

  AddUpdataDeletePostStates mapFailurOrPostsToState(
      Either<Failure, Unit> either, message) {
    return either.fold(
        (failure) =>
            ErrorAddUpdataDeletePostState(error: mapFailureToMessage(failure)),
        (_) => SuccessAddUpdataDeletePostState(message: message));
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error , Please Try again later ...';
    }
  }
}
