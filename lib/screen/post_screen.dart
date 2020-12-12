import 'package:bloc_infinite_list/bloc/post_bloc.dart';
import 'package:bloc_infinite_list/bloc/post_event.dart';
import 'package:bloc_infinite_list/bloc/post_state.dart';
import 'package:bloc_infinite_list/widget/bottom_lodaer.dart';
import 'package:bloc_infinite_list/widget/post_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_event.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _scrollController = ScrollController();
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(PostEvent.getPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post Screen"),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.status == PostStatus.initial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == PostStatus.failure) {
              return Center(
                child: Text('failed to fetch posts'),
              );
            }
            if (state.status == PostStatus.success) {
              if (state.posts.isEmpty) {
                return Center(
                  child: Text('no posts'),
                );
              } else
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return index >= state.posts.length
                        ? BottomLoader()
                        : PostItem(post: state.posts[index]);
                  },
                  itemCount: state.posts.length + 1,
                  controller: _scrollController,
                );
            } else {
              return Container();
            }
          },
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostEvent.getPosts);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }
}
