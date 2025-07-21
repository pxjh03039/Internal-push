import 'package:get_it/get_it.dart';
import 'package:push_test_app/data/repository/message_repository_impl.dart';
// import 'package:push_test_app/data/repository/mock_push_repository_impl.dart';
import 'package:push_test_app/data/repository/push_repository_impl.dart';
import 'package:push_test_app/data/repository/user_repository_impl.dart';
import 'package:push_test_app/domain/repository/message_repository.dart';
import 'package:push_test_app/domain/repository/push_repository.dart';
import 'package:push_test_app/domain/repository/user_repository.dart';
import 'package:push_test_app/presentation/create/create_view_model.dart';
import 'package:push_test_app/presentation/intro/intro_view_model.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
import 'package:push_test_app/presentation/profile/profile_view_model.dart';
import 'package:push_test_app/presentation/push/push_view_model.dart';
import 'package:push_test_app/presentation/update/update_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Repository
  getIt.registerSingleton<PushRepository>(PushRepositoryImpl());
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  getIt.registerSingleton<MessageRepository>(MessageRepositoryImpl());

  // ViewModel
  getIt.registerFactory<PushViewModel>(
      () => PushViewModel(pushRepository: getIt()));

  getIt.registerFactory<CreateViewModel>(
      () => CreateViewModel(pushRepository: getIt()));

  getIt.registerFactoryParam<UpdateViewModel, String, void>(
    (scheduleId, _) => UpdateViewModel(
      pushRepository: getIt(),
      scheduleId: scheduleId,
    ),
  );

  getIt.registerFactory<IntroViewModel>(
      () => IntroViewModel(userRepository: getIt()));

  getIt.registerFactory<ProfileViewModel>(
      () => ProfileViewModel(userRepository: getIt()));

  getIt.registerFactory<MessageViewModel>(() =>
      MessageViewModel(messageRepository: getIt(), userRepository: getIt()));
}
