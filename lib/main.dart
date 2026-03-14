import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/config/theme_manager/theme_manager.dart';
import 'package:movies_app/core/route_manager/route_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/services/custom_bloc_observer.dart';
import 'package:movies_app/core/services/get_it_service.dart';
import 'package:movies_app/core/repos/home_repo_impl.dart';
import 'package:movies_app/features/Auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:movies_app/features/explore/presentation/cubits/moviesbygenre/moviesbygenre_cubit.dart';
import 'package:movies_app/features/home/presentation/cubits/deatilsmovie/deatilsmovie_cubit.dart';
import 'package:movies_app/features/home/presentation/cubits/featuredmovies/featuredmovies_cubit.dart';
import 'package:movies_app/features/home/presentation/cubits/highratedmovies/highratedmovies_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app/features/profile/presentation/cubits/edit_profile/editprofile_cubit.dart';
import 'package:movies_app/features/profile/presentation/cubits/profile/profile_cubit.dart';
import 'package:movies_app/features/profile/presentation/cubits/watchlist/watchlist_cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  setup(); 
  Bloc.observer = CustomBlocObserver();

  runApp(const MoviesApp());
  
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HighratedmoviesCubit(getIt.get<HomeRepoImpl>())..fetchHighRatedMovies()),
        BlocProvider(create: (context) => FeaturedmoviesCubit(getIt.get<HomeRepoImpl>())..fetchFeaturedMovies()),
        BlocProvider(create: (context) => MoviesbygenreCubit(getIt.get<HomeRepoImpl>())..fetchMoviesbyGenre()),
        BlocProvider(create: (context) => DeatilsmovieCubit(getIt.get<HomeRepoImpl>())..fetchMoviesbyID(1)),
        BlocProvider(create: (context) => WatchlistCubit()),
        BlocProvider(create: (context) => ProfileCubit(getIt.get(), getIt.get())..getUserData()),
        BlocProvider(create: (context) => EditprofileCubit(getIt.get(), getIt.get())),
        BlocProvider(create: (context) => LoginCubit(getIt.get())),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: Size(430, 932),
        builder: (_, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteManager.onGenerateRoute,
          initialRoute: RouteManager.splash,
          themeMode: ThemeMode.light,
          theme: ThemeManager.light,
        ),
      ),
    );
  }
}
