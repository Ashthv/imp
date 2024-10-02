import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/acc_transaction_details_card.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key});

  @override
  Widget build(final BuildContext context) =>
      const AccountTransactionDetailsWidget(
        fileimagePath: 'images/debit.svg',
        imagePackage: 'uikit',
        transactionStatusImagePath: 'images/status.svg',
        transactionType: 'Debit',
        accNumber: 'Acc No 34568498298202',
        dateAndTime: '02/11/2023 at 1:04PM',
        transactionAmount: '-₹1098',
        transactionStatus: 'Successful',
      );
}
