import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:discrete_math/application/data/style/dark_style.dart';
import 'package:discrete_math/application/data/style/light_style.dart';
import 'package:discrete_math/core/auth/auth/bloc/auth_bloc.dart';
import 'package:discrete_math/core/auth/internet_connection/cubit/internet_cubit.dart';
import 'package:discrete_math/core/auth/internet_connection/state/internet_state.dart';
import 'package:discrete_math/core/auth/signup/bloc/signup_bloc.dart';
import 'package:discrete_math/core/auth/signup/service/signup_service.dart';
import 'package:discrete_math/core/graph/edit/cubit/edit_bloc.dart';
import 'package:discrete_math/core/graph/edit/service/edit_service.dart';
import 'package:discrete_math/core/graph/eulerian/bloc/eulirian_bloc.dart';
import 'package:discrete_math/core/graph/eulerian/service/eulirian_service.dart';
import 'package:discrete_math/core/graph/favorite/cubit/favorite_cubit.dart';
import 'package:discrete_math/core/graph/favorite/service/favorite_service.dart';
import 'package:discrete_math/core/graph/graphs/bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/graphs/service/graphs_service.dart';
import 'package:discrete_math/core/graph/hamiltonian/bloc/hamiltonian_bloc.dart';
import 'package:discrete_math/core/graph/hamiltonian/service/hamiltonian_service.dart';
import 'package:discrete_math/core/auth/login/bloc/login_bloc.dart';
import 'package:discrete_math/core/auth/login/service/login_service.dart';
import 'package:discrete_math/core/theme/cubit/theme_cubit.dart';
import 'package:discrete_math/core/theme/service/service_theme.dart';
import 'package:discrete_math/core/theme/state/state_theme.dart';
import 'package:discrete_math/firebase_options.dart';
import 'package:discrete_math/navigation/go_router.dart';
import 'package:discrete_math/presentation/screen/settings/no_internet_scree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://banatube.medium.com/mastering-flutter-custompainter-the-complete-developers-guide-f9b1e8575e6c
//https://medium.com/@punithsuppar7795/exploring-the-interactive-viewer-in-flutter-29fa05f786a5
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(create: (_) => InternetCubit(connectivity: connectivity)),
        // BlocProvider<DetourBloc>(
        //   create: (_) => DetourBloc(service: DetourService()),
        // ),
        // BlocProvider<BfsBloc>(create: (_) => BfsBloc(service: BfsService())),
        // BlocProvider<DfsBloc>(create: (_) => DfsBloc(service: DfsService())),
        BlocProvider<HamiltonianBloc>(
          create: (_) => HamiltonianBloc(service: HamiltonianService()),
        ),
        BlocProvider<EulerianBloc>(
          create: (_) => EulerianBloc(service: EulirianService()),
        ),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(LoginService())),
        BlocProvider<SignupBloc>(create: (_) => SignupBloc(SignupService())),
        BlocProvider<GraphsCubit>(create: (_) => GraphsCubit(GraphsService())),
        BlocProvider<EditCubit>(create: (_) => EditCubit(EditService())),
        BlocProvider<FavoriteCubit>(
          create: (_) => FavoriteCubit(FavoriteService()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        
        BlocProvider(
          create: (context) => ThemeCubit(
            ThemeLocalDataSource(context.read<SharedPreferences>()),
          ),
        ),
      ],
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetDisconnected) {
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
