import 'package:taxialong/features/home/domain/entities/terminal_entity.dart';

class AxisEntity {
  final int pointa;
  final int pointb;
  final TerminalEntity terminala;
  final TerminalEntity terminalb;

  AxisEntity({
    required this.pointa,
    required this.pointb,
    required this.terminala,
    required this.terminalb,
  });
}
