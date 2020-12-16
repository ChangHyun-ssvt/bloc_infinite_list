import 'dart:async';

import 'package:bloc_infinite_list/bloc/post_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostBloc', () {
    PostBloc postBloc;

    setUp(() {
      postBloc = PostBloc();
    });

    test('getPost', () async {
      final StreamSubscription subscription = postBloc.listen((data) {
        expect(data.posts.isNotEmpty, true);
        print("length    ${data.posts.length}");
      });

      postBloc.add(PostEvent.getPosts);
      await Future.delayed(Duration(seconds: 2));
      postBloc.add(PostEvent.getPosts);
      await Future.delayed(Duration(seconds: 2));
      postBloc.add(PostEvent.getPosts);
      await Future.delayed(Duration(seconds: 2));

      postBloc.close();
      subscription.cancel();
    });
  });
}
