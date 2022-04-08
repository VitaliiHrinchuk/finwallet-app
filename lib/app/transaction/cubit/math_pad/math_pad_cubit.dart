import 'package:bloc/bloc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:meta/meta.dart';

part 'math_pad_state.dart';

class MathPadCubit extends Cubit<MathPadState> {
  MathPadCubit() : super(MathPadInitial());

  void addValue(String char) {
    String result = this._formatResult(char);

    emit(state.copyWith(result: result));
  }

  void prepare() {
    emit(state.copyWith(result: this.calculate(this.state.result)));
  }

  String _formatResult(String char) {
    String result = this.state.result;
    bool isOperator = this._isOperator(char);

    if (char == '=') {
      return this.calculate(this.state.result);
    }

    if (isOperator && this.state.lastIsOperator) {
      return result;
    }

    if (result == '0' && !isOperator) {
      return char;
    }

    if (char == '<') {
      result = result.length > 0 ? result.substring(0, result.length - 1) : result;
    } else {
      if(this.state.containsDotSeparator) {
        if (!this.state.onlyTwoCharsAfterDot || isOperator) {
          return result + char;
        }
      } else {
        if (char == '.' && !this.state.onlyTwoCharsAfterDot && this.state.lastIsOperator) {
          return result + char;
        } else if (!isOperator) {
          return result + char;
        } if (isOperator && !this.state.lastIsOperator) {
          return result + char;
        }
      }
    }

    return result;
  }


  bool _isOperator(String char) {
    return operatorSigns.hasMatch(char);
  }

  String calculate(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);

    ContextModel cm = ContextModel();
    double res = exp.evaluate(EvaluationType.REAL, cm);
    return '${res.toStringAsFixed(2)}';
  }
}

