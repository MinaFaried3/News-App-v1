import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp1/shared/network/cashe_helper.dart';

import 'Main_State.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitMainState());
  static MainCubit get(context) => BlocProvider.of(context);

  bool? isDark = false;
  void Change_theme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeMainState());
    } else {
      isDark = !isDark!;
      CacheHelper.putBool(key: 'isDark', value: isDark!).then((value) {
        emit(ThemeMainState());
      });
    }
  }
}
