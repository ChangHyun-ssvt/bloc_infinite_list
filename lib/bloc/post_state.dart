import 'package:bloc_infinite_list/model/post.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final Post post;

  PostState({this.post});

  @override
  List<Object> get props => [post];
}
