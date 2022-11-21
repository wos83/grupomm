import styled from 'styled-components';

export const Container = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;

  @media (max-width: 480px) {
    max-height: calc(100vh - 172px);
    overflow: auto;
  }
`;

export const Title = styled.div`
  height: 48px;
  padding: 16px 0 16px 48px;

  > b {
    font-size: 32px;
    font-weight: 500;
  }
`;

export const Filters = styled.div`
  display: flex;
  flex-direction: row;
  height: 60%;
  padding: 16px;

  > div:first-child {
    width: 30%;

    @media (max-width: 480px) {
      width: 100%;
    }
  }

  > div:first-child + div {
    padding: 0 16px;
    width: 25%;

    @media (max-width: 480px) {
      padding: 16px 0;
      width: 100%;
    }
  }

  @media (max-width: 480px) {
    flex-direction: column;
  }
`;

export const Parameters = styled.div`
  position: relative;
  width: 45%;

  > div:first-child {
    margin-bottom: 2px;

    > b {
      color: ${({ theme }) => theme.colors.darkText};
      font-size: 16px;
      font-weight: 500;
    }
  }

  > div:first-child + div {
    display: flex;
    flex: 1;
    flex-wrap: wrap;
  }

  > div:last-child {
    bottom: 0;
    position: absolute;
    right: 0;

    @media (max-width: 480px) {
      left: 50%;
      transform: translateX(-50%);
      right: auto;
    }
  }

  @media (max-width: 480px) {
    padding-bottom: 48px;
    width: 100%;
  }
`;

export const InputWrapper = styled.div`
  margin-bottom: 16px;
  width: 50%;

  :nth-child(odd) {
    padding-right: 8px;
  }

  :nth-child(even) {
    padding-left: 8px;
  }
`;

export const CommandsHistoric = styled.div`
  display: flex;
  flex: 1;
  flex-direction: column;

  > b {
    font-size: 20px;
    font-weight: 500;
    margin: 0 0 8px 16px;
  }
`;

export const ContentGrid = styled.div`
  height: 100%;
  border-radius: 16px;
  margin: 0 16px 16px 16px;

  > div:first-child {
    max-height: calc(100vh - 592px);

    @media (max-width: 480px) {
      max-height: 240px;
    }
  }
`;
