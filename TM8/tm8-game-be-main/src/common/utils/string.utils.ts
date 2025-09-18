export class StringUtils {
  /**
   * Capitalizes first letter and convert the rest to lowercase.
   */
  static capitalizeOnlyFirstLetter(s: string): string {
    return s[0].toUpperCase() + s.slice(1).toLowerCase();
  }

  /**
   * Capitalizes first letter and leaves the rest as-is.
   */
  static capitalize(s: string): string {
    return s[0].toUpperCase() + s.slice(1);
  }

  /**
   * Capitalizes first letter of every word.
   */
  static toTitleCase(phrase: string): string {
    return phrase
      .toLowerCase()
      .split(' ')
      .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
  }

  /**
   * Generates a six digit numeric code
   */
  static generateSixDigitNumericCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  /**
   * Generates a seven digit alphanumeric code
   */
  static generateSevenDigitAlphaNumericCode(): string {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let code = '';
    const charactersLength = characters.length;

    for (let i = 0; i < 7; i++) {
      const randomIndex = Math.floor(Math.random() * charactersLength);
      code += characters.charAt(randomIndex);
    }

    return code;
  }

  /**
   * Generates a random password based on the given length input
   * @param length - password length
   * @returns password
   */
  static generatePassword(length: number): string {
    const charset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_';
    let password = '';
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * charset.length);
      password += charset[randomIndex];
    }

    // Check if the generated password satisfies the regex
    const regex =
      /^(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{":;'?/>.<,])(?!.*\s).*$/;
    if (!regex.test(password)) {
      // If the generated password doesn't satisfy the regex, recursively generate a new password until it does
      return StringUtils.generatePassword(length);
    }

    return password;
  }

  /**
   * Transforms a kebab-case string to a capitalized string
   * @param kebabCase - kebab-case string
   * @returns capitalized string
   */
  static kebabCaseToCapitalized(kebabCase: string): string {
    return kebabCase
      .split('-')
      .map((word) => {
        return word.charAt(0).toUpperCase() + word.slice(1);
      })
      .join(' ');
  }

  /**
   * Transforms a kebab-case string to a camelCase string
   * @param kebabCase - kebab-case string
   * @returns camelCase string
   */
  static kebabCaseToCamelCase(kebabCase: string): string {
    return kebabCase.replace(/-([a-z])/g, (g) => g[1].toUpperCase());
  }
}
