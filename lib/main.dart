import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:discrete_math/injections/service_locator.dart';
import 'package:discrete_math/core/settings/theme/presentation/style/dark_style.dart';
import 'package:discrete_math/core/settings/theme/presentation/style/light_style.dart';
import 'package:discrete_math/core/auth/auth/presentation/bloc/auth_bloc.dart';
import 'package:discrete_math/core/auth/internet_connection/presentation/bloc/internet_cubit.dart';
import 'package:discrete_math/core/graph/presentation/bloc/edit_bloc/edit_bloc.dart';
import 'package:discrete_math/core/favorite/presentation/bloc/favorite_cubit.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/settings/theme/presentation/bloc/theme_cubit.dart';
import 'package:discrete_math/core/settings/theme/presentation/bloc/state_theme.dart';
import 'package:discrete_math/firebase_options.dart';
import 'package:discrete_math/navigation/go_router.dart';
import 'package:discrete_math/core/auth/internet_connection/presentation/screen/no_internet_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://banatube.medium.com/mastering-flutter-custompainter-the-complete-developers-guide-f9b1e8575e6c
//https://medium.com/@punithsuppar7795/exploring-the-interactive-viewer-in-flutter-29fa05f786a5
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: RepositoryProvider.value(
        value: prefs,
        child: MainApp(connectivity: Connectivity()),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({required this.connectivity, super.key});
  final Connectivity connectivity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConnectivityCubit(getIt())),
        BlocProvider<GraphsCubit>(create: (_) => GraphsCubit(getIt())),
        BlocProvider<EditCubit>(
          create: (_) =>
              EditCubit(editGraphUsecase: getIt(), createGraphUsecase: getIt()),
        ),
        BlocProvider<FavoriteCubit>(create: (_) => FavoriteCubit(getIt())),
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(getIt(), getIt())),

        BlocProvider(create: (context) => ThemeCubit(getIt())),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityDisconnected) {
            return const MaterialApp(home: NoInternetScreen());
          }

          return BlocBuilder<ThemeCubit, AppThemeMode>(
            builder: (context, theme) {
              if (theme == AppThemeMode.loading) {
                return const SizedBox();
              }

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: router,
                themeMode: switch (theme) {
                  AppThemeMode.light => ThemeMode.light,
                  AppThemeMode.dark => ThemeMode.dark,
                  AppThemeMode.system => ThemeMode.system,
                  _ => ThemeMode.system,
                },
                theme: lightTheme,
                darkTheme: darkTheme,
              );
            },
          );
        },
      ),
    );
  }
}
