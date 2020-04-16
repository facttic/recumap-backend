import React from 'react';
import { List, Datagrid, TextField, BooleanField } from 'react-admin';

export const OrgList = props => (
    <List {...props}>
        <Datagrid>
            <TextField source="name" />
            <TextField source="description" />
            <TextField source="address" />
            <BooleanField source="public" />
        </Datagrid>
    </List>
);
