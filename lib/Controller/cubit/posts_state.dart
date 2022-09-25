part of 'posts_cubit.dart';

abstract class PostsState  {}

class PostsInitial extends PostsState {}
class PostsLoaded extends PostsState {
  final List<ClientDetails> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends PostsState {
  final List<ClientDetails> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch=false});
}

