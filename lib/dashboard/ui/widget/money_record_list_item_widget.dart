import 'package:flutter/material.dart';
import 'package:money_tracker/dashboard/model/money_record_model.dart';
import 'package:money_tracker/shard/app_colors.dart';

class MoneyRecordListItemWidget extends StatelessWidget {
  const MoneyRecordListItemWidget({super.key, required this.moneyRecord});

  final MoneyRecord moneyRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: moneyRecord.type == MoneyRecordType.expense
            ? expenseColor
            : incomeColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              moneyRecord.category,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              moneyRecord.amount.toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
