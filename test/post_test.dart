import 'package:bloc_infinite_list/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Post fromJson Test', () {
    List<Post> posts = List();
    var postsJson = [
      {
        "userId": 1,
        "id": 1,
        "title":
            "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body":
            "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      },
      {
        "userId": 1,
        "id": 2,
        "title": "qui est esse",
        "body":
            "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
      }
    ];

    postsJson.forEach((e) => posts.add(Post.fromJson(e)));

    expect(1, posts[0].id);
    expect(
        "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        posts[0].title);
    expect(
        "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla",
        posts[1].body);
  });
}
