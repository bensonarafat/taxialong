import 'package:taxialong/features/home/data/models/terminal_model.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';

class AxisModel extends AxisEntity {
  AxisModel({
    required super.pointa,
    required super.pointb,
    required super.terminala,
    required super.terminalb,
  });

  factory AxisModel.fromJson(Map<String, dynamic> json) {
    return AxisModel(
      pointa: json['point_a'],
      pointb: json['point_b'],
      terminala: TerminalModel.fromJson(
        json['terminal_a'],
      ),
      terminalb: TerminalModel.fromJson(
        json['terminal_b'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'point_a': pointa,
      'point_b': pointa,
      'terminal_a': terminala,
      'terminal_b': terminalb,
    };
  }
}
