import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firebase_storage_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/splash_screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controller/firebase/firebase_auth_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FireStoreController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseStorageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(context),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstants.primaryColor,
            primary: ColorConstants.primaryColor,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.rubikTextTheme(),
          // rubik,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorConstants.scaffoldBackgroundColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  const MaterialStatePropertyAll(ColorConstants.primaryWhite),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ColorConstants.categorySliderBackground;
                  }
                  return ColorConstants.primaryColor;
                },
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              overlayColor: MaterialStatePropertyAll(
                ColorConstants.primaryWhite.withOpacity(0.2),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ColorConstants.hintColor.withOpacity(0.3);
                  }
                  return ColorConstants.primaryColor;
                },
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              overlayColor: MaterialStatePropertyAll(
                ColorConstants.primaryColor.withOpacity(0.2),
              ),
              side: MaterialStateProperty.resolveWith(
                (states) {
                  return BorderSide(
                    width: 2.0,
                    color: states.contains(MaterialState.disabled)
                        ? ColorConstants.hintColor.withOpacity(0.3)
                        : ColorConstants.primaryColor,
                  );
                },
              ),
            ),
          ),
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: ColorConstants.scaffoldBackgroundColor),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
