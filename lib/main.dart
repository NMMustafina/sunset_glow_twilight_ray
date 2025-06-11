import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/color_ashfuoaj.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/onb_ashfih.dart';

import 'models/sunset_photo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SunsetPhotoModelAdapter());
  Hive.registerAdapter(SunsetCategoryAdapter());
  final box = await Hive.openBox<SunsetPhotoModel>('sunset_photos');
  GetIt.I.registerSingleton<Box<SunsetPhotoModel>>(box);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sunset Glow Twilight',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colorasdf.background,
          ),
          scaffoldBackgroundColor: Colorasdf.background,
          // fontFamily: '-_- ??',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const OnBoDiasdf(),
      ),
    );
  }
}
