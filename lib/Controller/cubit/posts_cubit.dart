import 'package:bloc/bloc.dart';
import 'package:debt_and_loan/Model/model.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/post_repositories.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.repository) : super(PostsInitial());

  int page = 1;
  final PostsRepository repository;

  void loadPosts() {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <ClientDetails>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

    print(page);
    print("calling");

    repository.fetchPosts(page).then((newPosts) {
      page++;

      print(newPosts.length);

      final posts = (state as PostsLoading).oldPosts;
      
        print("posts added");
        posts.addAll(newPosts);
     

      emit(PostsLoaded(posts));
    });
  }
}
