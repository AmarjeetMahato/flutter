import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/post/post_event.dart';
import 'package:flutter_widgets/bloc/post/post_state.dart';
import 'package:flutter_widgets/repository/post_repository.dart';
import 'package:flutter_widgets/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostState()) {
    on<PostFetched>(_postFetch);
  }

  void _postFetch(PostFetched event, Emitter<PostState> emit) async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      final value = await postRepository.fetchPost();
      emit(
        state.copyWith(
          postStatus: PostStatus.success,
          message: 'Post fetch successfully',
          postList: value,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          postStatus: PostStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }
}
