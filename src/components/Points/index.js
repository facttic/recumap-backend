import React from 'react';
import { List, Datagrid } from 'react-admin';

export const PointsList = props => (
    <List {...props}>
        <Datagrid rowClick="edit">
        </Datagrid>
    </List>
);
