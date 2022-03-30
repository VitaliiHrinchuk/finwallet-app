part of 'math_pad_cubit.dart';

RegExp operatorSigns = RegExp(r'[*,\-,+,=,\.]');
RegExp endWithOperatorRegExp = RegExp(r'[*,\-,+,=,\.]$');

class MathPadState {
  final String result;
  
  bool get isExpression => operatorSigns.hasMatch(this.result);
  bool get lastIsOperator => endWithOperatorRegExp.hasMatch(this.result);
  bool get containsDotSeparator => RegExp(r'\.').hasMatch(this.result);
  bool get onlyTwoCharsAfterDot => RegExp(r'.*\.[0-9]{2}$').hasMatch(this.result);

  MathPadState({
    this.result = '',
  });

  MathPadState copyWith({result}) =>
      MathPadState(
          result: result ?? this.result
      );

}

class MathPadInitial extends MathPadState {}

