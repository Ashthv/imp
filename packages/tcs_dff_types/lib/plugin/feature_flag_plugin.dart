
import '../tcs_dff_types.dart';

abstract interface class FeatureFlagPlugin implements Plugin {

bool getBool(final String key);

double getDouble(final String key);

int getInt(final String key);

String getString(final String key);
} 