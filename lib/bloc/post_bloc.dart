import 'package:bloc_infinite_list/bloc/post_event.dart';
import 'package:bloc_infinite_list/bloc/post_state.dart';
import 'package:bloc_infinite_list/common/constants.dart';
import 'package:bloc_infinite_list/model/post.dart';
import 'package:bloc_infinite_list/service/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    switch (event) {
      case PostEvent.getPosts:
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostSuccess(posts: posts);
          break;
        }
        break;
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
