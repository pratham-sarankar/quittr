import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quittr/core/bloc_observer.dart';
import 'package:quittr/core/injection_container.dart' as di;
import 'package:quittr/core/presentation/theme/theme.dart';
import 'package:quittr/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quittr/features/auth/presentation/screens/auth_wrapper.dart';
import 'package:quittr/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:quittr/features/breathing_exercise/presentation/bloc/breathing_bloc.dart';
import 'package:quittr/features/breathing_exercise/presentation/screens/breathing_excercise_page.dart';
import 'package:quittr/features/home/presentation/screens/home_screen.dart';
import 'package:quittr/features/meditate/presentation/bloc/quotes_bloc.dart';
import 'package:quittr/features/meditate/presentation/screens/meditate_screen.dart'
    as meditate;
import 'package:quittr/features/motivaton/presentation/screens/motivation_screen.dart';
import 'package:quittr/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:quittr/features/reason/presentation/screens/reason_list_screen.dart';
import 'package:quittr/features/relapse_tracker/presentation/bloc/relapse_tracker_bloc.dart';
import 'package:quittr/features/settings/presentation/screens/settings_screen.dart';
import 'package:quittr/features/side%20effects/presentaion/screens/side_effects_screen.dart';
import 'package:quittr/firebase_options.dart';
import 'package:quittr/core/presentation/theme/cubit/theme_cubit.dart';
import 'package:quittr/features/auth/presentation/screens/auth_screen.dart';
import 'package:quittr/features/auth/presentation/screens/email_auth_screen.dart';
import 'package:quittr/features/journal/presentation/screens/journal_screen.dart';
import 'package:quittr/features/paywall/presentation/bloc/paywall_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependency injection
  await di.init();

  // Set up BlocObserver
  Bloc.observer = AppBlocObserver();

  runApp(const QuittrApp());
}

class QuittrApp extends StatelessWidget {
  const QuittrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository: di.sl())),
        BlocProvider(create: (_) => ThemeCubit(settingsRepository: di.sl())),
        BlocProvider<PaywallBloc>(
          lazy: false,
          create: (context) => di.sl<PaywallBloc>()
            ..add(const InitializePaywall())
            ..add(const VerifySubscriptionEvent()),
        ),
        BlocProvider(create: (_) => RelapseTrackerBloc()),
        BlocProvider(create: (_) => BreathingBloc()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          final theme = MaterialTheme(GoogleFonts.poppinsTextTheme());
          return MaterialApp(
            title: 'Quittr',
            debugShowCheckedModeBanner: false,
            theme: theme.light(),
            darkTheme: theme.dark(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const AuthWrapper(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/auth': (context) => const AuthScreen(),
              '/email-auth': (context) => const EmailAuthScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/edit-profile': (context) => const EditProfileScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/recovery-journal': (context) => const JournalScreen(),
              '/reason-list': (context) => const ReasonListScreen(),
              '/meditate-screen': (context) => const meditate.MeditateScreen(),
              '/motivation-screen': (context) => const MotivationScreen(),
              '/breathing-exercise-screen': (context) =>
                  const BreathingExcercisePage(),

                  '/side-effects-screen' : (context) => const SideEffectsScreen(),
            },
          );
        },
      ),
    );
  }
}
