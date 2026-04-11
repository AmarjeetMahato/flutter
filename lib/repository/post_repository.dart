import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:flutter_widgets/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  // Initialize logger with a pretty printer
  final logger = Logger(
    printer: PrettyPrinter(methodCount: 0, lineLength: 80, colors: true),
  );

  Future<List<PostModel>> fetchPost() async {
    try {
      logger.i("1. Entering fetchPost function..."); // Add this
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'PostApp/1.0', // This tells the server who is calling
        },
      );
      logger.i(
        "3. Response received! Status: ${response.statusCode}",
      ); // Add this
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((e) {
          return PostModel(
            postId: e['postId'],
            id: e['id'],
            name: e['name'] as String,
            email: e['email'] as String,
            body: e['body'] as String,
          );
        }).toList();
      }
    } on SocketException catch (e) {
      logger.e('No Internet Connection $e');
      return [];
    } on HttpException catch (e) {
      logger.e('Could not find the resource $e');
      return [];
    } catch (e, stacktrace) {
      logger.f(
        "Critical failure",
        error: e,
        stackTrace: stacktrace,
      ); // Fatal log
      rethrow;
    }
    return [];
  }
}
