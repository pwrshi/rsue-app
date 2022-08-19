part of "../../../main.dart";

var lightTheme = ThemeData(
    primaryColor: Color.fromARGB(255, 151, 135, 89),
    secondaryHeaderColor: Colors.blue.shade50,
    fontFamily: "Rubik",
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: "Rubik",
            fontSize: 22)),
    useMaterial3: true,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 151, 135, 89),
        onPrimary: Colors.black,
        secondary: Colors.blue.shade50,
        onSecondary: Colors.white,
        background: Colors.red,
        onBackground: Colors.purple,
        surface: Colors.pink,
        onSurface: Color.fromARGB(255, 151, 135, 89),
        onError: Colors.orange,
        error: Colors.deepOrange));
