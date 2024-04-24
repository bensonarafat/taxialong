import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxialong/core/domain/entities/terminal_entity.dart';

class TaxiAlongTerminalsPage extends StatefulWidget {
  final List<TerminalEntity> terminals;
  const TaxiAlongTerminalsPage({
    super.key,
    required this.terminals,
  });

  @override
  State<TaxiAlongTerminalsPage> createState() => _TaxiAlongTerminalsPageState();
}

class _TaxiAlongTerminalsPageState extends State<TaxiAlongTerminalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Terminal',
        ),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.close,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: widget.terminals.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pop(context, widget.terminals[index]);
            },
            title: Text(widget.terminals[index].name),
          );
        },
      ),
    );
  }
}
