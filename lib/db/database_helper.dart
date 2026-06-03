// Conditional export: use IO implementation on VM, web implementation on browser
export 'database_helper_io.dart'
    if (dart.library.html) 'database_helper_web.dart';
