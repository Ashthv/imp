import '../theme/size.dart';
import 'sizer/app_sizer.dart';

enum CreditCardStatus {
  active,
  inactive,
  blocked,
}

double getHeight(final CreditCardStatus status) {
  switch (status) {
    case CreditCardStatus.inactive:
      return AppSizes.size207.dp;
    case CreditCardStatus.blocked:
      return AppSizes.size190.dp;
    default:
      return AppSizes.size175.dp;
  }
}
