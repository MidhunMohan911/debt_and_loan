import 'package:debt_and_loan/Model/model.dart';
import 'package:debt_and_loan/Services/services.dart';

class PostsRepository {
  final ClientServices service;

  PostsRepository(this.service);

  Future<List<ClientDetails>> fetchPosts(int page) async {
    await Future.delayed(const Duration(seconds: 2));
    final posts = await service.fetchPosts(page);
    return posts!;
  }
}
