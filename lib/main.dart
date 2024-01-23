import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_updata_dalate/a_u_d_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/bloc_opserver.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<AddUpdataDeletePostBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Posts',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const PostsPage(),
      ),
    );
  }
}
