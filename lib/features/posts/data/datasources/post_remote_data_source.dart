import 'dart:convert';

import 'package:clean_architecture_posts_app/core/msg_fail_ex/exeptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemotedataSouce {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> addPost(PostModel post);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemotedataSouce {
  final http.Client client;
  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BASE_URL + "/posts/"),
        headers: {"COnstent-type": "application/json"});
    // success 200
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerExecptoion();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);

    /// add post  201
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExecptoion();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
        headers: {"COnstent-type": "application/json"});
    // delete success status code 200
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExecptoion();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };
    final response =
        await client.patch(Uri.parse(BASE_URL + "/posts/$postId"), body: body);
    // update status code = 200
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExecptoion();
    }
  }
}
