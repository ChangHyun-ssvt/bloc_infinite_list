import 'package:bloc_infinite_list/model/post.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final int lastPostId;

  PostState(
      {this.status = PostStatus.initial, this.posts, this.lastPostId = 0});

  PostState copyWith({
    PostStatus status,
    List<Post> posts,
    int lastPostId,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      lastPostId: lastPostId ?? this.lastPostId,
    );
  }

  @override
  List<Object> get props => [status, posts, lastPostId];
}
