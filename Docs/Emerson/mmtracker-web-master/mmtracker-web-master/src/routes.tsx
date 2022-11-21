import { BrowserRouter, Routes as Switch, Route } from 'react-router-dom';

import Header from './components/header';
import Sidebar from './components/sidebar';
import { IPages } from './interfaces/pages';
import Commands from './modules/commands';
import Login from './modules/login';
import Map from './modules/map';
import Reports from './modules/reports';

const clientPath = '/mmtracker';

const getPages = (): Array<IPages> => {
  return [
    {
      path: `${clientPath}/`,
      dynamicImport: <Login />,
      hasMenu: false,
      access: 'public',
    },
    {
      path: `${clientPath}/map`,
      dynamicImport: <Map />,
      hasMenu: true,
      icon: 'home',
      access: 'private',
      name: 'Mapa',
    },
    {
      path: `${clientPath}/reports`,
      dynamicImport: <Reports />,
      hasMenu: true,
      icon: 'reports',
      access: 'private',
      name: 'Reports',
    },
    {
      path: `${clientPath}/commands`,
      dynamicImport: <Commands />,
      hasMenu: true,
      icon: 'commands',
      access: 'private',
      name: 'Commands',
    },
  ];
};

function PrivateRoute({
  children,
  hasMenu,
}: {
  children: JSX.Element;
  hasMenu: boolean;
}) {
  if (hasMenu)
    return (
      <div id="background">
        <Sidebar />
        <div id="content-header-body">
          <Header />
          {children}
        </div>
      </div>
    );

  return children;
}

function Routes() {
  return (
    <BrowserRouter>
      <Switch>
        {getPages().map((page) => {
          return (
            <Route
              path={page.path}
              element={
                <PrivateRoute hasMenu={page.hasMenu}>
                  {page.dynamicImport}
                </PrivateRoute>
              }
            />
          );
        })}
      </Switch>
    </BrowserRouter>
  );
}

export default Routes;
