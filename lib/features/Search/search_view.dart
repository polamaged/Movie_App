import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/repos/home_repo.dart';
import 'package:movies_app/core/repos/home_repo_impl.dart';
import 'package:movies_app/core/services/get_it_service.dart';
import 'package:movies_app/features/Search/presentation/cubits/moviesearch/moviesearch_cubit.dart';
import 'package:movies_app/features/Search/presentation/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesearchCubit(getIt.get<HomeRepoImpl>()),
      child: Scaffold(body: SafeArea(child: SearchViewbody())),
    );
  }
}
