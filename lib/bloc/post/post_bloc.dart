import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/post/post_event.dart';
import 'package:flutter_widgets/bloc/post/post_state.dart';
import 'package:flutter_widgets/model/post_model.dart';
import 'package:flutter_widgets/repository/post_repository.dart';
import 'package:flutter_widgets/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  List<PostModel> temPostList = [];
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostState()) {
    on<PostFetched>(_postFetch);
    on<SearchItem>(_filterItem);
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

  void _filterItem(SearchItem event, Emitter<PostState> emit) async {
    // 1. Handle empty search: If search is empty, reset temPostList
    if (event.stSearch.isEmpty) {
      emit(state.copyWith(temPostList: []));
    }

    final String searchTerm = event.stSearch.toLowerCase().toString();

    temPostList = state.postList!.where((post) {
      final int? searchAsInt = int.tryParse(event.stSearch);
      final bool idMatch = searchAsInt != null
          ? post.id ==
                searchAsInt // Exact match for numbers
          : post.id.toString().contains(searchTerm);

      final bool nameMatch = post.name.toString().toLowerCase().contains(
        searchTerm,
      );
      final bool emailMatch = post.email.toString().toLowerCase().contains(
        searchTerm,
      );
      final bool bodyMatch = post.body.toString().toLowerCase().contains(
        searchTerm,
      );

      return idMatch || nameMatch || emailMatch || bodyMatch;
    }).toList();
    emit(state.copyWith(temPostList: temPostList));
  }
}
