import 'package:bloc_infinite_list/model/post.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFailure extends PostState {}

class PostSuccess extends PostState {
  final List<Post> posts;

  PostSuccess({this.posts});

  @override
  List<Object> get props => [posts];
}
