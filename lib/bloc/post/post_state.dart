import 'package:equatable/equatable.dart';
import 'package:flutter_widgets/model/post_model.dart';
import 'package:flutter_widgets/utils/enums.dart';

class PostState extends Equatable {
  final PostStatus? postStatus;
  final List<PostModel>? postList;
  final List<PostModel> temPostList;
  final String message;

  const PostState({
    this.postStatus = PostStatus.loading,
    this.postList = const [],
    this.temPostList = const <PostModel>[],
    this.message = '',
  });

  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postList,
    List<PostModel>? temPostList,
    String? message,
  }) {
    return PostState(
      postList: postList ?? this.postList,
      postStatus: postStatus ?? this.postStatus,
      temPostList: temPostList ?? this.temPostList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [postStatus, postList, temPostList, message];
}
