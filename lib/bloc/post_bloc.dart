import 'package:bloc_infinite_list/bloc/post_event.dart';
import 'package:bloc_infinite_list/bloc/post_state.dart';
import 'package:bloc_infinite_list/common/constants.dart';
import 'package:bloc_infinite_list/model/post.dart';
import 'package:bloc_infinite_list/service/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState(hasReachedMax: false));

  final int _postLimit = 20;

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    switch (event) {
      case PostEvent.getPosts:
        print("getPosts");
        yield await _mapPostFetchedToState(state);
    }
  }

  Future<PostState> _mapPostFetchedToState(PostState state) async {
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(state.lastPostId, _postLimit);
        return state.copyWith(
          status: PostStatus.success,
          posts: posts,
          lastPostId: posts.last.id,
          hasReachedMax: _hasReachedMax(posts.length),
        );
      } else {
        final posts = await _fetchPosts(state.lastPostId, _postLimit);
        return posts.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                lastPostId: state.hasReachedMax ? 0 : posts.last.id,
                hasReachedMax: _hasReachedMax(posts.length));
      }
    } catch (e) {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    ApiHelper apiHelper =
        ApiHelper(url: '$postUrl?_start=$startIndex&_limit=$limit');

    final response = await apiHelper.getData();
    List<Post> _posts = List();
    response.forEach((postRaw) {
      _posts.add(Post.fromJson(postRaw));
    });
    return _posts;
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? true : false;
}
