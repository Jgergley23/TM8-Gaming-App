import 'package:form_builder_validators/form_builder_validators.dart';

const passwordRegex =
    r"(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+}{&quot;:;'?/&gt;.&lt;,])(?!.*\s).*$";
final passwordMatch = FormBuilderValidators.match(
  passwordRegex,
  errorText: 'Requires at least one uppercase, and one digit',
);

const nameRegex = r"^[a-zA-Z]+(?: [a-zA-Z]+)+$";
final nameMatch = FormBuilderValidators.match(
  nameRegex,
  errorText: 'Requires full name',
);

final emailValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please enter email address'),
    FormBuilderValidators.email(),
  ],
);

final passwordValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please enter password'),
    FormBuilderValidators.minLength(8),
    passwordMatch,
  ],
);

final noteValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please enter a note'),
    FormBuilderValidators.maxLength(60),
  ],
);

final userNoteValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please enter a note'),
    FormBuilderValidators.maxLength(150),
  ],
);

final requiredRadioValidator = FormBuilderValidators.required(
  errorText: 'Please select an option',
);

final titleValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please set title'),
    FormBuilderValidators.maxLength(30),
  ],
);

final bodyValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please set body'),
    FormBuilderValidators.maxLength(150),
  ],
);

final nameValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(errorText: 'Please enter name'),
    FormBuilderValidators.maxLength(30),
    nameMatch,
  ],
);
