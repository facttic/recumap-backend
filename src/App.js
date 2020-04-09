import React from 'react';
import './App.css';

import { Admin, Resource } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';

import { UserList } from './users';
import customRoutes from './customRoutes'
import authProvider from './authProvider'
import PrivateHome from './components/PrivateHome'

// Test data provider
const dataProvider = jsonServerProvider('https://jsonplaceholder.typicode.com');

const App = () => (
  <Admin
    authProvider={authProvider}
    customRoutes={customRoutes}
    dataProvider={dataProvider}
    dashboard={PrivateHome}
  >
    <Resource name="users" list={UserList} />
  </Admin>
);

export default App;
