import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/NewsLayout.dart';
import 'package:newsapp1/main_cubit/Main_Cubit.dart';
import 'package:newsapp1/main_cubit/Main_State.dart';
import 'package:newsapp1/shared/network/cashe_helper.dart';
import 'package:newsapp1/shared/network/dio_helper.dart';

import 'BlocObserver.dart';
import 'cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows) await DesktopWindow.setMinWindowSize(Size(450, 750));
  DioHelper.Init_dio();

  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init_sahred();
      bool? isDark = CacheHelper.getBool(key: 'isDark');
      runApp(Mino(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class Mino extends StatelessWidget {
  @override
  final bool? isDark;
  Mino(this.isDark);

  Color theme1 = Color(0xfff6ebd1);
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              MainCubit()..Change_theme(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        )
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
                primarySwatch: Colors.amber,
                scaffoldBackgroundColor: Color(0xff264B5E),
                appBarTheme: AppBarTheme(
                    backgroundColor: Color(0xff264B5E),
                    titleTextStyle: TextStyle(
                      color: Color(0xfffff5dd),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                    iconTheme: IconThemeData(color: Color(0xfffff5dd)),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xfffff5dd),
                        statusBarIconBrightness: Brightness.dark)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff2f5a72),
                  selectedItemColor: Color(0xfffff5dd),
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: false,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Color(0xfffff5dd),
                  foregroundColor: Color(0xff264B5E),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        color: Color(0xfffaecd2),
                        fontWeight: FontWeight.w500))),
            theme: ThemeData(
                primarySwatch: Colors.cyan,
                scaffoldBackgroundColor: theme1,
                appBarTheme: AppBarTheme(
                    backgroundColor: theme1,
                    titleTextStyle: TextStyle(
                      color: Color(0xff264B5E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                    iconTheme: IconThemeData(color: Color(0xff264B5E)),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff264B5E),
                        statusBarIconBrightness: Brightness.light)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Color(0xfffff5dd),
                    selectedItemColor: Color(0xff2f5a72),
                    unselectedItemColor: Colors.grey,
                    showUnselectedLabels: false,
                    elevation: 70),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Color(0xff264B5E),
                  foregroundColor: Color(0xfffff5dd),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        color: Color(0xff264B5E),
                        fontWeight: FontWeight.w500))),
            themeMode: MainCubit.get(context).isDark!
                ? ThemeMode.dark
                : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
