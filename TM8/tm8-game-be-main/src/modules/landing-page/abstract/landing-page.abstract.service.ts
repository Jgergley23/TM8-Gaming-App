import { ContactFormInput } from '../dto/contact-form.input';

export abstract class AbstractLandingPageService {
  abstract sendContactForm(contactFormInput: ContactFormInput): Promise<void>;
}
