part of "../../../main.dart";

var darkTheme = ThemeData(
    fontFamily: "Rubik",
    primaryColor: Color.fromARGB(255, 151, 135, 89),
    secondaryHeaderColor: Colors.blueGrey.shade800,
    textTheme: TextTheme(button: TextStyle(color: Colors.white)),
    backgroundColor: Colors.grey.shade900,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Rubik",
            fontSize: 22)),
    useMaterial3: true,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 151, 135, 89),
        onPrimary: Colors.white,
        secondary: Colors.blueGrey.shade800,
        onSecondary: Colors.white,
        background: Colors.red,
        onBackground: Colors.purple,
        surface: Colors.pink,
        onSurface: Color.fromARGB(255, 151, 135, 89),
        onError: Colors.orange,
        error: Colors.deepOrange));
