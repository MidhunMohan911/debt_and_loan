import 'package:debt_and_loan/Screens/home_screen.dart';
import 'package:debt_and_loan/Services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Controller/cubit/posts_cubit.dart';
import 'repositories/post_repositories.dart';

void main() {
  runApp(MyApp(
    repository: PostsRepository(ClientServices()),
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostsView(),
      ),
    );
  }
}