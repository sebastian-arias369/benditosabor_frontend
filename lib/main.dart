import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:benditosabor/routes/app_router.dart';
import 'package:benditosabor/themes/app_themes.dart';

void main() async {
  // Asegurarse de que los widgets de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Optimizar la carga del .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }
  // Inicializar dotenv para cargar las variables de entorno
  // await dotenv.load(fileName: ".env");
  // Inicializar el servicio de autenticación (carga usuario desde SharedPreferences)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //go_router para navegacion
    return MaterialApp.router(
      theme:
          AppTheme.lightTheme, //thema personalizado y permamente en toda la app
      title: 'Bendito Sabor', // Usa el tema personalizado.
      routerConfig: appRouter, // Usa el router configurado
    );
  }
}

