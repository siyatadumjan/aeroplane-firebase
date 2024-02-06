import 'package:aeroplane/ui/pages/ChooseTransportatioin.dart';
import 'package:aeroplane/ui/pages/MybookingPage.dart';
import 'package:aeroplane/ui/pages/choose_seat_page.dart';
import 'package:aeroplane/ui/pages/profile/profilePage.dart';
import 'package:aeroplane/ui/pages/profile/update_profile_page.dart';
import 'package:aeroplane/ui/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:aeroplane/cubit/auth_cubit.dart';
import 'package:aeroplane/cubit/page_cubit.dart';
import 'package:aeroplane/ui/pages/bonus_page.dart';
import 'package:aeroplane/ui/pages/get_started_page.dart';
import 'package:aeroplane/ui/pages/main_page.dart';
import 'package:aeroplane/ui/pages/sign_in_page.dart';
import 'package:aeroplane/ui/pages/sign_up_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'ui/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => AuthCubit())
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, routes: {
        '/': (context) => SplashPage(),
        '/get-started': (context) => GetStartedPage(),
        '/sign-up': (context) => SignUpPage(),
        '/bonus': (context) => BonusPage(),
        '/main': (context) => MainPage(),
        '/sign-in': (context) => SignInPage(),
        '/my_booing': (context) => TransactionPage(),
        '/ChooseSeatPage': (context) => ChooseSeatPage(),
        '/ChooseTransportationPage': (context) => ChooseTransportationPage(),
        '/SettingPage': (context) => SettingPage(),
        '/profile': (context) => UserProfile(),
        '/update_profile': (context) => UpdateUserProfile(),
      }),
    );
  }
}
