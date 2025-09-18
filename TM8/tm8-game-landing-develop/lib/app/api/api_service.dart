import 'package:tm8l/env/env.dart';
import 'package:tm8l/swagger_generated_code/swagger.swagger.dart';

final api = Swagger.create(
  baseUrl: Uri(
    scheme: 'https',
    host: Env.stagingBaseURL,
  ),
);
