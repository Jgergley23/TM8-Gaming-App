import { faker } from '@faker-js/faker';

import { ContactFormInput } from '../../dto/contact-form.input';

export const contactFormInput: ContactFormInput = {
  firstName: faker.person.firstName(),
  lastName: faker.person.lastName(),
  email: faker.internet.email(),
  message: faker.lorem.sentence(),
};
