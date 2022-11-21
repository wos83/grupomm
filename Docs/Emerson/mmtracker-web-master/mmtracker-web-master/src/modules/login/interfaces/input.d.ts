export interface ILoginInputProps {
  icon: IconifyIcon;
  className?: string | undefined;
  value: string;
  onChange: React.ChangeEventHandler<HTMLInputElement> | undefined;
  placeholder: stirng;
  height?: number;
  rightIcon?: IconifyIcon;
}
