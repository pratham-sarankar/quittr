import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quittr/core/presentation/theme/cubit/theme_cubit.dart';
import 'package:quittr/features/meditate/data/datasources/meditate_loacal_data_source.dart';
import 'package:quittr/features/meditate/data/repository/quotes_repository_impl.dart';
import 'package:quittr/features/meditate/domain/repository/quotes_repository.dart';
import 'package:quittr/features/meditate/domain/usecases/get_quotes.dart';
import 'package:quittr/features/meditate/presentation/bloc/quotes_bloc.dart';
import 'package:quittr/features/motivaton/data/data_sources/motivation_quotes_local_datasource.dart';
import 'package:quittr/features/motivaton/data/repository/motivational_quotes_repository_impl.dart';
import 'package:quittr/features/motivaton/domain/repository/motivation_quotes_repository.dart';
import 'package:quittr/features/motivaton/domain/usecases/get_motivationalQuotes.dart';
import 'package:quittr/features/paywall/data/datasources/purchase_data_source.dart';
import 'package:quittr/features/paywall/domain/usecases/verify_subscription.dart';
import 'package:quittr/features/paywall/presentation/bloc/paywall_bloc.dart';
import 'package:quittr/features/side%20effects/data/data_sources/side_effects_local_datasource.dart';
import 'package:quittr/features/side%20effects/data/repository/side_effects_repository_impl.dart';
import 'package:quittr/features/side%20effects/domian/repository/side_effectes_repository.dart';
import 'package:quittr/features/side%20effects/domian/usecases/get_side_effects.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/profile/domain/usecases/update_profile_photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quittr/core/services/image_picker_service.dart';
import 'package:quittr/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:quittr/core/database/database_helper.dart';
import 'package:quittr/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:quittr/features/settings/domain/repositories/settings_repository.dart';
import 'package:quittr/features/onboarding/data/datasources/quiz_local_data_source.dart';
import 'package:quittr/features/onboarding/data/repositories/quiz_repository_impl.dart';
import 'package:quittr/features/onboarding/domain/repositories/quiz_repository.dart';
import 'package:quittr/features/onboarding/presentation/bloc/quiz_bloc.dart';
import 'package:quittr/features/journal/domain/usecases/get_journal_entries.dart';
import 'package:quittr/features/journal/domain/usecases/add_journal_entry.dart';
import '../features/journal/data/repositories/journal_repository_impl.dart';
import '../features/journal/domain/repositories/journal_repository.dart';
import '../features/paywall/domain/usecases/initialize_purchases.dart';
import '../features/paywall/domain/usecases/get_subscriptions.dart';
import '../features/paywall/domain/usecases/purchase_product.dart';
import '../features/paywall/data/repositories/purchase_repository_impl.dart';
import '../features/paywall/domain/repositories/purchase_repository.dart';
import '../features/paywall/domain/usecases/get_purchase_updates.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
    ),
  );

  // Features - Profile
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      auth: sl(),
      storage: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);

  // Services
  sl.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImpl(picker: sl()),
  );
  sl.registerLazySingleton(() => ImagePicker());

  // Use cases
  sl.registerLazySingleton(() => UpdateProfilePhoto(sl()));

  // Blocs
  sl.registerFactory(() => SettingsBloc(repository: sl()));

  // Database
  sl.registerLazySingleton(() => DatabaseHelper.instance);

  // Repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => ThemeCubit(settingsRepository: sl()));

  // Quiz Feature
  sl.registerFactory(() => QuizBloc(repository: sl()));
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(),
  );

  // Journal Feature
  sl.registerLazySingleton(() => GetJournalEntries(sl()));
  sl.registerLazySingleton(() => AddJournalEntry(sl()));
  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(databaseHelper: sl()),
  );

  // Features - meditation

  sl.registerFactory<MeditateLoacalDataSource>(
      () => MeditateLoacalDataSourceImpl());

  sl.registerFactory<QuotesRepository>(() => QuotesRepositoryImpl(sl()));

  sl.registerFactory(() => GetQuotes(sl()));

  // Paywall
  sl.registerLazySingleton(
    () => PaywallBloc(
      initializePurchases: sl(),
      getProducts: sl(),
      purchaseProduct: sl(),
      verifySubscription: sl(),
      getPurchaseUpdates: sl(),
    ),
  );

  sl.registerLazySingleton(() => InitializePurchases(sl()));
  sl.registerLazySingleton(() => GetSubscriptions(sl()));
  sl.registerLazySingleton(() => PurchaseProduct(sl()));
  sl.registerLazySingleton(() => VerifySubscription(sl()));
  sl.registerLazySingleton(() => GetPurchaseUpdates(sl()));

  // Repositories
  sl.registerLazySingleton<PurchaseRepository>(
    () => PurchaseRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<PurchaseDataSource>(
    () => PurchaseDataSourceImpl(),
  );

  //Feature :- Motivation

  sl.registerFactory<MotivationQuotesLocalDatasource>(
      () => MotivationQuotesLocalDatasourceImpl());
  sl.registerFactory<MotivationQuotesRepository>(
      () => MotivationalQuotesRepositoryImpl(sl()));
  sl.registerFactory(() => GetMotivationalquotes(sl()));

  // Features :- Side Effects

  sl.registerFactory<SideEffectsLocalDatasource>(
      () => SideEffectsLocalDatasourceImpl());
  sl.registerFactory<SideEffectesRepository>(
      () => SideEffectsRepositoryImpl(sl()));
  sl.registerFactory(() => GetSideEffects(sl()));
}
