import 'package:bloc_infinite_list/model/post.dart';
import 'package:bloc_infinite_list/widget/post_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final posts = [
    Post(body: "body", title: "title", id: 0),
    Post(body: "body", title: "title", id: 1)
  ];
  testWidgets("PostItem Widget", (WidgetTester tester) async {
    await tester.pumpWidget(ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: posts.length,
      itemBuilder: (context, index) => PostItem(
        post: posts[index],
      ),
    ));
  });
}
