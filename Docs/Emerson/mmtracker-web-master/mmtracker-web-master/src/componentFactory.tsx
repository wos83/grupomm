import {
  createContext,
  createElement,
  ReactNode,
  useEffect,
  useState,
} from 'react';

import { IPages } from './interfaces/pages';
import NotFound from './modules/notFound';

// import Loader from './components/loader';

type IProps = IPages;

export const AuthContext = createContext({} as IProps);

function RouteComponent(props: IPages, routeComponent: ReactNode): JSX.Element {
  return (
    <AuthContext.Provider value={props}>{routeComponent}</AuthContext.Provider>
  );
}

function ComponentFactory(props: IProps): JSX.Element {
  const [routeComponent, setRouteComponent] = useState<ReactNode>(NotFound);
  const { dynamicImport, hasMenu } = props;

  useEffect(() => {
    (async () => {
      await import(`./${dynamicImport}`)
        .then((module) => {
          setRouteComponent(createElement(module.default));
        })
        .catch((err) => {
          setRouteComponent(NotFound);
          console.error(err);
        });
    })();
  }, [dynamicImport]);

  return (
    <div>
      {hasMenu ? (
        <div id="component-body">{RouteComponent(props, routeComponent)}</div>
      ) : (
        RouteComponent(props, routeComponent)
      )}
    </div>
  );
}

export default ComponentFactory;
