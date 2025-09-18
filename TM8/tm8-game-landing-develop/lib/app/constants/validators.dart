import 'package:form_builder_validators/form_builder_validators.dart';

final requiredValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(),
    FormBuilderValidators.maxLength(20),
  ],
);

final emailValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.email(),
    FormBuilderValidators.required(),
  ],
);

final checkBoxValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.equal(true, errorText: 'Must agree to continue.'),
  ],
);

final messageValidator = FormBuilderValidators.compose(
  [
    FormBuilderValidators.required(),
    FormBuilderValidators.maxLength(200),
  ],
);
