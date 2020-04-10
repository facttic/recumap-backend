import React from 'react';
import './App.css';

import { Admin, Resource } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';

import { PointsList } from './components/Points';
import { UserList } from './components/Users';
import customRoutes from './customRoutes'
import authProvider from './authProvider'
import PrivateHome from './components/PrivateHome'
import AppLayout from './AppLayout'

// Test data provider
const dataProvider = jsonServerProvider('https://jsonplaceholder.typicode.com');

const App = () => (
  <Admin
    authProvider={authProvider}
    customRoutes={customRoutes}
    dataProvider={dataProvider}
    dashboard={PrivateHome}
    layout={AppLayout}
  >
    <Resource name="users" list={UserList} />
    <Resource name="Puntos" list={PointsList} />
  </Admin>
);

export default App;
