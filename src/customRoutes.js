import React from 'react';
import { Route } from 'react-router-dom';
import { Authenticated } from 'react-admin';
import PrivateHome from './components/PrivateHome'
import PublicHome from './components/PublicHome'
import HousesMap from './components/Houses/HousesMap'
import ResourcesMap from './components/Resources/ResourcesMap'

export default [
    <Route
      exact path="/home"
      render={() =>
        <Authenticated>
            <PrivateHome />
        </Authenticated>
      }
    />,
    <Route exact path="/" component={PublicHome} />,
    <Route exact path="/houses/map" component={HousesMap} />,
    <Route exact path="/resources/map" component={ResourcesMap} />,
];