import React from 'react';
import './App.css';

import { Admin, Resource } from 'react-admin';

import { HouseEdit, HouseList, HouseShow, HouseCreate } from './components/Houses';
import {
  ResourceList,
  ResourcePost,
  ResourceEdit,
  ResourceShow
} from './components/Resources';
// import { UserList } from './components/Users';
import { OrgList } from './components/Orgs';
import customRoutes from './customRoutes'
import PrivateHome from './components/PrivateHome'
import AppLayout from './AppLayout'
import { AuthProvider, DataProvider } from './providers'


const App = () => (
  <Admin
    authProvider={AuthProvider}
    customRoutes={customRoutes}
    dataProvider={DataProvider}
    dashboard={PrivateHome}
    layout={AppLayout}
  >
    <Resource
      name="houses"
      edit={HouseEdit}
      list={HouseList}
      show={HouseShow}
      create={HouseCreate}
    />
    <Resource name="orgs" list={OrgList} />
    <Resource
      name="resources"
      list={ResourceList}
      edit={ResourceEdit}
      create={ResourcePost}
      show={ResourceShow}
    />
  </Admin>
);

export default App;
