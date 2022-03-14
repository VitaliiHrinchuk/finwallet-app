import 'package:rules/rules.dart';

import 'contracts.dart';
import 'error/exceptions.dart';

class _Condition {
  final String name;
  final dynamic firstParameter;
  final dynamic secondParameter;

  _Condition(this.name, this.firstParameter, this.secondParameter);
}

class RuleValidator extends ValidatorContract {
  Map<String, String> rules = {};
  Map<String, dynamic> values = {};
  Map<String, String> names = {};
  late Map<String, Rule Function(Rule rule, dynamic param1, dynamic param2)>
  ruleMap;

  static bool fieldExist(String field) {
    return false;
  }

  RuleValidator() {
    this.ruleMap = {
      'email': (rule, _, __) {
        return rule.copyWith(isEmail: true);
      },
      'required': (rule, _, __) {
        return rule.copyWith(isRequired: true);
      },
      'greaterThan': (rule, param1, _) {
        return rule.copyWith(greaterThan: double.parse(param1));
      },
      'lessThan': (rule, param1, _) {
        return rule.copyWith(lessThan: double.parse(param1));
      },
      'equalTo': (rule, param1, _) {
        return rule.copyWith(equalTo: param1);
      },
      'shouldMatch': (rule, param1, param2) {
        return rule.copyWith(shouldMatch: param1, customErrors: {"shouldMatch": "This field should be same as ${param2 ?? param1}"});
      },
      'numeric': (rule, _, __) {
        return rule.copyWith(isNumeric: true);
      },
      'required_without': (rule, param1, __) {
        if (values.containsKey(param1) && values[param1] != null) {
          return rule.copyWith(isRequired: false);
        } else {
          return rule.copyWith(isRequired: true);
        }
      },
    };
  }

  setRules(Map<String, String> rules) {
    this.rules = rules;
  }

  setValues(Map<String, dynamic> values) {
    this.values = values;
  }

  validate() {
    Map<String, String> invalid = {};

    this.rules.forEach((String key, strRules) {
      List<_Condition> conditions = this._strToCondition(strRules);
      String name = names[key] == null ? key : names[key]!;

      Rule rule = Rule(values[key], name: name);
      conditions.forEach((condition) {
        rule = _mapRule(condition, rule);
        if (rule.hasError) {
          invalid[key] = rule.error!;
        }
      });
    });
    print(invalid);
    if (invalid.length > 0) {
      throw ValidationException(invalid);
    }
  }

  List<_Condition> _strToCondition(String rules) {
    return rules.split("|").map((String item) {
      List<String> params = item.split(":");
      int len = params.length;
      return _Condition(
          params[0], len > 1 ? params[1] : null, len > 2 ? params[2] : null);
    }).toList();
  }

  Rule _mapRule(_Condition condition, Rule rule) {
    if (ruleMap.containsKey(condition.name)) {
      return ruleMap[condition.name]!(
          rule, condition.firstParameter, condition.secondParameter);
    } else {
      return rule;
    }
  }
}
