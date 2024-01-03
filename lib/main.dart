import 'package:el_grocer/api/save_db_api/save_db_api.dart';
import 'package:el_grocer/domain/api_client/network_client.dart';
import 'package:el_grocer/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:el_grocer/domain/blocs/categories_bloc/categories_bloc.dart';
import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_cubit.dart';
import 'package:el_grocer/domain/blocs/location_cubit/location_cubit.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc.dart';
import 'package:el_grocer/domain/blocs/themes/themes_bloc.dart';
import 'package:el_grocer/routes/routes.dart';
import 'package:el_grocer/widget/auth/auth_cubit.dart';
import 'package:el_grocer/widget/loader_page/loader_view_cubit.dart';
import 'package:el_grocer/widget/main_page/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/blocs/auth_bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NetworkClient.initDio();
  saveToDb(LaravelSave());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(
      create: (_) => CategoriesBloc(),
    ),
    BlocProvider(create: (_) => MainBloc()),
    BlocProvider(create: (_) => ProductsBloc()),
    BlocProvider(create: (_) => CartBloc()),
    BlocProvider(create: (_) => LoaderViewCubit()),
    BlocProvider(create: (_) => AuthViewCubit()),
    BlocProvider(create: (_) => ThemesBloc()),
    BlocProvider(create: (_) => LocationCubit()),
    BlocProvider(create: (_) => FavoriteCubit()),
    BlocProvider(create: (_) => SortBloc()),
  ], child: const MyApp()));
}

void saveToDb(SaveDbApi saveDbApi) {
  saveDbApi.saveToDb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesBloc, ThemesBlocState>(builder: (BuildContext context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: state.themesModel.currentState == ThemesState.light
            ? state.themesModel.lightTheme
            : state.themesModel.darkTheme,
        // theme: ThemeData.light(useMaterial3: true,),
        routes: Routes.pathRoutes(),
        initialRoute: '/',
      );
    });
  }
}
