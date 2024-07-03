import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Withdrawals extends StatelessWidget {
  const Withdrawals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdrawals',
        ),
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
    );
  }
}
