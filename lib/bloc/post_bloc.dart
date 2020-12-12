import 'package:bloc_infinite_list/bloc/post_event.dart';
import 'package:bloc_infinite_list/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) {
    throw UnimplementedError();
  }
}
