export interface InputProps {
  placeholder: string;

  backgroundColor?: string;

  /**
   * @param {String} none 0px
   * @param {String} sm 2px
   * @param {String} base 4px
   * @param {String} md 6px
   * @param {String} lg 8px
   * @param {String} xl 12px
   * @param {String} full 9999px
   */
  borderRadius?: 'none' | 'sm' | 'base' | 'md' | 'lg' | 'xl' | 'full';

  label?: string;

  /**
   * @param {String} xs 24px
   * @param {String} sm 32px
   * @param {String} md 40px
   * @param {String} lg 48px
   */
  size?: 'xs' | 'sm' | 'md' | 'lg';
}
