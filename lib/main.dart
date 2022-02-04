import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'data/authentication/models/user.dart';
import 'data/manage_payattu/models/user_payattu.dart';
import 'data/payattu/models/payattu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final storage = await HydratedStorage.build(
  //     storageDirectory: await getApplicationDocumentsDirectory());
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PayattuAdapter());
  Hive.registerAdapter(UserPayattuAdapter());
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0Mzc5MjYwMCwiZXhwIjoxOTU5MzY4NjAwfQ.grvAsfDv1E6EeJz1tmNRKbVinoYhcraE4zmE8YbK08k',
    url: 'https://zlqnelvmcsquoulmicev.supabase.co',
  );
  // HydratedBlocOverrides.runZoned(() => runApp(const App()), storage: storage);
  runApp(const App());
}
