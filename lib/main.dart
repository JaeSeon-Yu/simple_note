import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_note/di/provider_setup.dart';
import 'package:simple_note/routes.dart';
import 'package:simple_note/ui/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await getProviders();

  runApp(MultiProvider(
   providers: providers,
   child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        primaryColor: Colors.white,
        canvasColor: darkGray,
        floatingActionButtonTheme:
            Theme.of(context).floatingActionButtonTheme.copyWith(
                  backgroundColor: Colors.white,
                  foregroundColor: darkGray,
                ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
      ),
      initialRoute: Routes.notesScreen,
      onGenerateRoute: Pages.generateRoute, //const NotesScreen(),
    );
  }
}
