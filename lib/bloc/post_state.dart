import 'package:bloc_infinite_list/model/post.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final int lastPostId;
  final bool hasReachedMax;

  PostState(
      {this.status = PostStatus.initial,
      this.posts,
      this.lastPostId = 0,
      this.hasReachedMax});

  PostState copyWith({
    PostStatus status,
    List<Post> posts,
    int lastPostId,
    bool hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      lastPostId: lastPostId ?? this.lastPostId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
