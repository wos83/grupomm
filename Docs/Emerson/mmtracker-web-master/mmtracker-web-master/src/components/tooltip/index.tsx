import { useTheme } from 'styled-components';

import { Tooltip as TooltipChakra } from '@chakra-ui/react';

interface ITooltip {
  arrowSize?: number;
  children: JSX.Element;
  hasArrow?: boolean;
  label: string;
  position?: 'top' | 'bottom';
  width?: number;
}

function Tooltip({
  arrowSize = 8,
  children,
  hasArrow = true,
  label,
  position = 'top',
  width = 16,
}: ITooltip): JSX.Element {
  const theme = useTheme();

  return (
    <TooltipChakra
      textAlign="center"
      arrowSize={arrowSize}
      bg={theme.colors.secundary}
      hasArrow={hasArrow}
      label={label}
      placement={position}
      width={width}>
      {children}
    </TooltipChakra>
  );
}

export default Tooltip;
