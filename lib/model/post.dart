import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String userId;
  final String id;
  final String title;
  final String body;

  Post({this.userId, this.title, this.body, this.id})
      : assert(userId != null && title != null && body != null && id != null);

  @override
  List<Object> get props => [userId, id, title, body];
}
