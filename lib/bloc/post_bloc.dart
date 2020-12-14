import 'package:bloc_infinite_list/bloc/post_state.dart';
import 'package:bloc_infinite_list/common/constants.dart';
import 'package:bloc_infinite_list/model/post.dart';
import 'package:bloc_infinite_list/service/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum PostEvent { getPosts }

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState(posts: []));

  final int _postLimit = 20;

  @override
  void onChange(Change<PostState> change) {
    print(change.nextState.status);
    super.onChange(change);
  }

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    switch (event) {
      case PostEvent.getPosts:
        try {
          if (state.lastPostId != 100) {
            final posts = await _fetchPosts(state.lastPostId, _postLimit);
            yield state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              lastPostId: posts.last.id,
            );
            break;
          } else {
            final posts = await _fetchPosts(0, _postLimit);
            yield state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                lastPostId: _postLimit);
          }
        } catch (e) {
          yield state.copyWith(status: PostStatus.failure);
        }
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
}
