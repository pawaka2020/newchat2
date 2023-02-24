import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// We only have a single SupabaseClient to improve app performance and reduce
/// resource usage.
final supabaseClient = Supabase.instance.client;

