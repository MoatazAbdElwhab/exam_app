// features/result/data/data_sources/result_local_data_source.dart

import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/data/data_models/dummy/result_dummy_data.dart';
import 'package:injectable/injectable.dart';

abstract class ResultLocalDataSource {
  Future<ResultResponseModel> getResult();
}

@LazySingleton(as: ResultLocalDataSource)
class ResultLocalDataSourceImpl implements ResultLocalDataSource {
  @override
  Future<ResultResponseModel> getResult() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return ResultDummyData.resultResponse;
  }
}
