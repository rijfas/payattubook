import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0Mzc5MjYwMCwiZXhwIjoxOTU5MzY4NjAwfQ.grvAsfDv1E6EeJz1tmNRKbVinoYhcraE4zmE8YbK08k',
    url: 'https://zlqnelvmcsquoulmicev.supabase.co',
  );
  runApp(const App());
}
