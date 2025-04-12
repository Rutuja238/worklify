// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'routes/app_routes.dart';
// import 'viewmodel/onboarding/onboarding_viewmodel.dart';
// import 'viewmodel/home/home_viewmodel.dart';
// import 'package:firebase_core/firebase_core.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
//         ChangeNotifierProvider(create: (_) => HomeViewModel()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: AppRoutes.onboarding,
//         onGenerateRoute: AppRoutes.generateRoute,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_routes.dart';
import 'viewmodel/onboarding/onboarding_viewmodel.dart';
import 'viewmodel/home/home_viewmodel.dart';
import 'blocs/task/task_bloc.dart';
import 'models/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Hive setup
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  await Hive.openBox<TaskModel>('tasksBox');

  // runApp(const MyApp());
  runApp(MyApp(taskBox: taskBox));
}

class MyApp extends StatelessWidget {
  final Box<TaskModel> taskBox;

  const MyApp({super.key, required this.taskBox});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TaskBloc(taskBox)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.onboarding,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
