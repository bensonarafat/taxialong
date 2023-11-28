import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/features/home/data/models/axis_model.dart';

const cacheAxisKey = 'CACHED_AXIS';

abstract class HomeLocalDataSource {
  Future<void>? cacheAxis(AxisModel axismodel);
  Future<AxisModel> getLastCacheAxis();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheAxis(AxisModel? axismodel) {
    if (axismodel != null) {
      sharedPreferences.setString(
        cacheAxisKey,
        json.encode(axismodel.toJson()),
      );
    } else {
      throw CacheException();
    }
    return null;
  }

  @override
  Future<AxisModel> getLastCacheAxis() {
    final jsonString = sharedPreferences.getString(cacheAxisKey);
    if (jsonString != null) {
      return Future.value(AxisModel.fromJson(json.decode(jsonString)));
    }
    throw CacheException();
  }
}
