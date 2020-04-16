import React from 'react';
import {
  Create,
  Edit,
  List,
  Datagrid,
  NumberInput,
  SimpleForm,
  TextField,
  TextInput,
  Show,
  SimpleShowLayout
} from 'react-admin';

export const ResourceList = props => (
    <List {...props}>
        <Datagrid rowClick="edit">
          <TextField source="name" />
          <TextField source="details" />
          <TextField source="responsible_name" />
          <TextField source="responsible_surname" />
          <TextField source="responsible_phone" />
        </Datagrid>
    </List>
);


export const ResourcePost = (props) => (
    <Create {...props}>
        <SimpleForm>
          <TextInput source="name" />
          <TextInput source="responsible_name" />
          <TextInput source="responsible_surname" />
          <TextInput source="responsible_dni" />
          <TextInput source="responsible_phone" />
          <TextInput source="address_between_streets" />
          <TextInput source="address_locality" />
          <TextInput source="address_neighborhood" />
          <NumberInput  source="address_number" />
          <TextInput source="address_street" />
          <TextInput source="details" />
          <NumberInput source="lat" />
          <NumberInput source="long" />
          <NumberInput source="resource_type_id" />
        </SimpleForm>
    </Create>
);

export const ResourceEdit = (props) => (
    <Edit {...props}>
        <SimpleForm>
            <TextInput source="name" />
            <TextInput source="responsible_name" />
            <TextInput source="responsible_surname" />
            <TextInput source="responsible_dni" />
            <TextInput source="responsible_phone" />
            <TextInput source="address_between_streets" />
            <TextInput source="address_locality" />
            <TextInput source="address_neighborhood" />
            <NumberInput  source="address_number" />
            <TextInput source="address_street" />
            <TextInput source="details" />
            <NumberInput source="lat" />
            <NumberInput source="long" />
            <NumberInput source="resource_type_id" />
        </SimpleForm>
    </Edit>
);

export const ResourceShow = (props) => (
  <Show {...props}>
      <SimpleShowLayout>
        <TextField source="address_between_streets" />
        <TextField source="address_locality" />
        <TextField source="address_neighborhood" />
        <TextField source="address_number" />
        <TextField source="address_street" />
        <TextField source="details" />
        <TextField source="id" />
        <TextField source="lat" />
        <TextField source="long" />
        <TextField source="name" />
        <TextField source="responsible_dni" />
        <TextField source="responsible_name" />
        <TextField source="responsible_phone" />
        <TextField source="responsible_surname" />
      </SimpleShowLayout>
  </Show>
)
