import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> setup() async {
  //----------------------------------------------------------------------------
  await dotenv.load(fileName: ".env");
  //----------------------------------------------------------------------------
  await Supabase.initialize(
    url: dotenv.env['url_supabase'].toString(),
    anonKey: dotenv.env['key_supabase'].toString(),
  );
  //----------------------------------------------------------------------------
  await GetStorage.init();
  //----------------------------------------------------------------------------
  // Needed so TableCalendar / DateFormat can render Arabic month & weekday names.
  await initializeDateFormatting('en');
  await initializeDateFormatting('ar');
  //----------------------------------------------------------------------------
}
