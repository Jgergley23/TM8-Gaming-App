export class DateUtils {
  /**
   * Calculates a date exactly one year from the original date, adjusting for leap years.
   * @param originalDate - original date
   * @returns number of days until the anniversary date
   */
  static calculateAnniversaryInterval(originalDate: Date): number {
    const currentDate = new Date();
    const differenceInDays = Math.floor(
      (currentDate.getTime() - originalDate.getTime()) / (1000 * 60 * 60 * 24),
    );
    const originalYear = originalDate.getFullYear();
    const currentYear = currentDate.getFullYear();
    let interval = currentYear - originalYear;

    // Adjust for leap years
    for (let year = originalYear; year < currentYear; year++) {
      if (this.isLeapYear(year)) {
        interval++;
      }
    }

    // Example: Adjust interval based on difference in days
    if (differenceInDays > 365) {
      interval++;
    }

    return interval;
  }

  /**
   * Checks if year is leap year
   * @param year - year
   * @returns boolean
   */
  static isLeapYear(year: number): boolean {
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
  }

  /**
   * Calculates number of days in a month
   * @param month - month number
   * @param year - year
   * @returns number of days in month
   */
  static daysInMonth(month: number, year: number): number {
    return new Date(year, month, 0).getDate();
  }
}
