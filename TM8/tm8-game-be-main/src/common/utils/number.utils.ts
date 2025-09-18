export class NumberUtils {
  /**
   * Creates expiry date in seconds
   * @param expInSeconds - expiry in seconds
   * @returns number
   */
  static makeExpiryDate(expInSeconds: number): number {
    const expiryDays = expInSeconds / 24;
    const expiryDate = new Date();

    expiryDate.setDate(expiryDate.getDate() + expiryDays);
    const expiryDateInseconds = Math.floor(expiryDate.getTime() / 1000);
    return expiryDateInseconds;
  }

  /**
   * Creates issued at time in seconds
   * @returns number
   */
  static issuedAtTime(): number {
    const issuedAt = Date.now();
    const issuedAtInSeconds = Math.floor(issuedAt / 1000);

    return issuedAtInSeconds;
  }

  /**
   * Checks if a numeric value is in range
   * @param value
   * @param min
   * @param max
   * @returns
   */
  static isNumericValueInRange(
    value: number,
    min: number,
    max: number,
  ): boolean {
    return value >= min && value <= max;
  }
}
