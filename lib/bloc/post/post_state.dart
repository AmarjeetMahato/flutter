import 'package:equatable/equatable.dart';
import 'package:flutter_widgets/model/post_model.dart';
import 'package:flutter_widgets/utils/enums.dart';

class PostState extends Equatable {
  final PostStatus? postStatus;
  final List<PostModel>? postList;
  final String message;

  const PostState({this.postStatus, this.postList, this.message = ''});

  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postList,
    String? message,
  }) {
    return PostState(
      postList: postList ?? this.postList,
      postStatus: postStatus ?? this.postStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [postStatus, postList, message];
}
