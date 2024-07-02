import '../core/api/end_points.dart';

class DeleteModel {
  final String message;

  DeleteModel({required this.message});

  factory DeleteModel.fromJson(Map<String, dynamic> jsonData) {
    return DeleteModel(
      message: jsonData[ApiKeys.message],
    );
  }
}