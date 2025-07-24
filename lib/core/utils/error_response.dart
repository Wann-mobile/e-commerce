import 'package:e_triad/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class ErrorResponse extends Equatable {
  const ErrorResponse({this.type, this.message, this.errorMessage});

  factory ErrorResponse.fromMap(DataMap map) {
    var errMsgs =
        (map['errors'] as List?)
            ?.cast<DataMap>()
            .map((e) => e['message'] as String)
            .toList();
    if (errMsgs != null && errMsgs.isEmpty) errMsgs = null;

    return ErrorResponse(
      type: map['type'] as String?,
      message: map['message'] as String?,
      errorMessage: errMsgs,
    );
  }

  final String? type;
  final String? message;
  final List<String>? errorMessage;

  String get errMsg{
    var payload = '';
    if(type != null) payload = '$type: ';
    if(message != null) {payload += '$message';}
    else{
      if(errorMessage != null){
        payload += '\n$message';
        for (final (index, messages) in errorMessage!.indexed){
          if(index == 0){
            payload += '\n$messages';
          } else {
            payload += '\n\n- $messages';
          }
        }
      }
    }
  return payload;
  }

  @override
  List<Object?> get props => [type, message];
}
