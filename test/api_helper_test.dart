import 'package:bloc_infinite_list/common/constants.dart';
import 'package:bloc_infinite_list/model/post.dart';
import 'package:bloc_infinite_list/service/api_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get Post Data", () async {
    ApiHelper apiHelper = ApiHelper(url: postUrl);
    final response = await apiHelper.getData();
    List<Post> _posts = List();

    response.forEach((postRaw) {
      _posts.add(Post.fromJson(postRaw));
    });

    expect(_posts.isNotEmpty, true);
  });
}
