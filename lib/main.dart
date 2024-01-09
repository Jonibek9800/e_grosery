import 'package:el_grocer/user_app/api/save_db_api/save_db_api.dart';
import 'package:el_grocer/user_app/domain/api_client/network_client.dart';
import 'package:el_grocer/user_app/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:el_grocer/user_app/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:el_grocer/user_app/domain/blocs/categories_bloc/categories_bloc.dart';
import 'package:el_grocer/user_app/domain/blocs/favorite_cubit/favorite_cubit.dart';
import 'package:el_grocer/user_app/domain/blocs/list_state_cubit/product_list_cubit.dart';
import 'package:el_grocer/user_app/domain/blocs/list_state_cubit/search_list_cubit.dart';
import 'package:el_grocer/user_app/domain/blocs/location_cubit/location_cubit.dart';
import 'package:el_grocer/user_app/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/user_app/domain/blocs/sort_bloc/sort_bloc.dart';
import 'package:el_grocer/user_app/domain/blocs/themes/themes_bloc.dart';
import 'package:el_grocer/user_app/routes/routes.dart';
import 'package:el_grocer/user_app/utils/global_context_helper.dart';
import 'package:el_grocer/user_app/widget/auth/auth_cubit.dart';
import 'package:el_grocer/user_app/widget/loader_page/loader_view_cubit.dart';
import 'package:el_grocer/user_app/widget/main_page/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider(create: (_) => SearchListCubit()),
    BlocProvider(create: (_) => ProductListCubit()),
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
        navigatorKey: GlobalContext.globalNavigatorContext,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: state.themesModel.currentState == ThemesState.light
            ? state.themesModel.lightTheme
            : state.themesModel.darkTheme,
        routes: Routes.pathRoutes(),
        initialRoute: '/',
      );
    });
  }
}
