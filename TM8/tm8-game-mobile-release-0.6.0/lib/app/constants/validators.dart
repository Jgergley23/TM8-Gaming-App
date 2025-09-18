import 'package:form_builder_validators/form_builder_validators.dart';

const passwordRegex =
    '^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$%^&()_+}{":;\'?/>.<,])(?!.*\\s).{8,}\$';

final passwordMatch = FormBuilderValidators.match(
  passwordRegex,
  errorText: 'Please create a strong password.',
);

final passwordMatchLogin = FormBuilderValidators.match(
  passwordRegex,
  errorText: 'Password is incorrect.',
);
final emailValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(
      errorText: 'Please enter a valid email address',
    ),
    FormBuilderValidators.email(),
  ],
);

final passwordValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please provide your password'),
    FormBuilderValidators.minLength(8),
    passwordMatch,
  ],
);

final passwordValidatorLogin = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please provide your password'),
    FormBuilderValidators.minLength(8),
    passwordMatchLogin,
  ],
);

final usernameValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(
      errorText: 'Please provide your username',
    ),
    FormBuilderValidators.minLength(2),
    FormBuilderValidators.maxLength(16),
  ],
);
final descriptionValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(
      errorText: 'Please provide your description',
    ),
    FormBuilderValidators.minLength(2),
    FormBuilderValidators.maxLength(100),
  ],
);

final dateValidator = FormBuilderValidators.compose(
  [
    CustomDateValidator.validateDate,
  ],
);

final requiredRadioValidator = FormBuilderValidators.required(
  errorText: 'Please select an option',
);

final dateMatchmakingValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(
      errorText: 'Please enter a valid date',
    ),
  ],
);

class CustomDateValidator extends FormBuilderValidators {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide your DOB';
    } else {
      final date = DateTime.parse(value);
      final thirteenYearsAgo =
          DateTime.now().subtract(const Duration(days: 13 * 365));
      if (date.isAfter(thirteenYearsAgo)) {
        return 'You must be at least 13 years old';
      }
    }
    return null;
  }
}
