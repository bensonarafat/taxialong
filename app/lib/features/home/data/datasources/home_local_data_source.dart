import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';

const cacheAxisKey = 'CACHED_AXIS';

abstract class HomeLocalDataSource {
  Future<void>? cacheAxis(List<AxisModel> axismodel);
  Future<List<AxisModel>> getLastCacheAxis();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheAxis(List<AxisModel>? axismodel) {
    if (axismodel != null) {
      final List<Map<String, dynamic>> axisJsonList =
          axismodel.map((axis) => axis.toJson()).toList();
      sharedPreferences.setString(
        cacheAxisKey,
        json.encode(axisJsonList),
      );
    } else {
      throw CacheException();
    }
    return null;
  }

  @override
  Future<List<AxisModel>> getLastCacheAxis() {
    final jsonString = sharedPreferences.getString(cacheAxisKey);
    if (jsonString != null) {
      List<dynamic> jsonResponse = json.decode(jsonString);

      List<AxisModel> list =
          jsonResponse.map((item) => AxisModel.fromJson(item)).toList();
      return Future.value(list);
    }
    throw CacheException();
  }
}
