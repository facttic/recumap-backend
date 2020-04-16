import React from 'react';
import Grid from '@material-ui/core/Grid';
import {
  Create,
  Datagrid,
  Edit,
  List,
  Show,
  SimpleForm,
  SimpleShowLayout,
  TextField,
  TextInput,
  BooleanField,
  BooleanInput,
  NumberInput
} from 'react-admin';

export const HouseList = props => (
    <List {...props}>
        <Datagrid rowClick="edit">
            <TextField source="name" />
            <TextField source="address_locality" />
            <TextField source="address_neighborhood" />
            <TextField source="food_help" />
            <TextField source="healh_issues" />
        </Datagrid>
    </List>
);

export const HouseCreate = props => (
    <Create title="Agregar Hogar" {...props}>
	       <SimpleForm>
              <h2>Datos del Responsable</h2>
              <TextInput label="Nombre del responsable" source="responsible_name" />
              <TextInput label="Apellido del responsable" source="responsible_surname" />
              <TextInput label="DNI del responsable" source="responsible_dni" />
              <TextInput label="Teléfono del responsable" source="responsible_phone" />
              <h2>Datos del Hogar</h2>
              <TextInput label="Calle" source="address_street" />
              <NumberInput label="Número" source="address_number" />
              <TextInput label="Barrio" source="address_neighborhood" />
              <TextInput label="Entre calles" source="address_between_streets" />
              <TextInput label="Locality" source="address_locality" />
              <NumberInput source="lat" />
              <NumberInput source="long" />
              <h2>Integrantes del hogar</h2>
              <NumberInput label="Canidad de integrantes" source="number_of_members" />
              <NumberInput label="Cantidad de menores en el hogar" source="number_of_minor_members" />
              <NumberInput label="Cantidad de adultos en el hogar" source="number_of_older_members" />
              <BooleanInput label="¿Algún problema de salud" source="healh_issues" />
              <h2>Ingresos</h2>
              <BooleanInput label="¿Recibe Ingresos de la economía formal?" source="earnings_formal_economy" />
              <BooleanInput label="¿Se vieron afectados sus ingresos por el Aislamiento Preventivo Obligatorio?" source="earnings_affected_isolation" />
              <BooleanInput label="¿Recibe IFE?" source="family_emergency_plan" />
              <BooleanInput label="¿Es beneficiarie de algún plan social?" source="benefited_by_social_plan" />
              <h2>Necesidades</h2>
              <BooleanInput label="¿Retira bolsón de comida en alguna institución educativa o municipal cercana a su domicilio?" source="attends_community_dining_room" />
              <BooleanInput label="¿Asiste a algún comedor?" source="food_help" />
	       </SimpleForm>
    </Create>
);

export const HouseShow = props => (
    <Show {...props}>
        <SimpleShowLayout>
            <h2>Datos del Responsable</h2>
            <TextField label="Nombre del responsable" source="responsible_name" />
            <TextField label="Apellido del responsable" source="responsible_surname" />
            <TextField label="DNI del responsable" source="responsible_dni" />
            <TextField label="Teléfono del responsable" source="responsible_phone" />
            <h2>Datos del Hogar</h2>
            <TextField label="Calle" source="address_street" />
            <TextField label="Número" source="address_number" />
            <TextField label="Barrio" source="address_neighborhood" />
            <TextField label="Entre calles" source="address_between_streets" />
            <TextField label="Locality" source="address_locality" />
            <TextField source="lat" />
            <TextField source="long" />
            <h2>Integrantes del hogar</h2>
            <TextField label="Canidad de integrantes" source="number_of_members" />
            <TextField label="Cantidad de menores en el hogar" source="number_of_minor_members" />
            <TextField label="Cantidad de adultos en el hogar" source="number_of_older_members" />
            <BooleanField label="¿Algún problema de salud" source="healh_issues" />
            <h2>Ingresos</h2>
            <BooleanField label="¿Recibe Ingresos de la economía formal?" source="earnings_formal_economy" />
            <BooleanField label="¿Se vieron afectados sus ingresos por el Aislamiento Preventivo Obligatorio?" source="earnings_affected_isolation" />
            <BooleanField label="¿Recibe IFE?" source="family_emergency_plan" />
            <BooleanField label="¿Es beneficiarie de algún plan social?" source="benefited_by_social_plan" />
            <h2>Necesidades</h2>
            <BooleanField label="¿Retira bolsón de comida en alguna institución educativa o municipal cercana a su domicilio?" source="attends_community_dining_room" />
            <BooleanField label="¿Asiste a algún comedor?" source="food_help" />
	      </SimpleShowLayout>
    </Show>
);

export const HouseCreate1 = (props) => (
    <Create {...props}>
        <SimpleForm>
            <Grid container spacing={1}>
                <Grid item xs={6}>
                    <NumberInput label="Resp. dni" source="responsible_dni" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="Resp name" source="responsible_name" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="Resp. surn" source="responsible_surname" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="Resp. phone" source="responsible_phone" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="A.between" source="address_between_streets" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="A.locality" source="address_locality"  />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="A.nhood" source="address_neighborhood" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="A.number" source="address_number" />
                </Grid>
                <Grid item xs={12}>
                    <TextInput label="A.street" source="address_street" />
                </Grid>
                <Grid item xs={12}>
                <BooleanInput
                    source="benefied_by_social_plan"
                />
                <BooleanInput
                    source="attends_community_dining_room"
                />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput source="lat" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput source="long" />
                </Grid>
                <Grid item xs={12}>
                    <BooleanInput source="earnings_affected_isolation" /> 
                    <BooleanInput source="earnings_formal_economy" />
                    <BooleanInput source="family_emergency_plan" />
                    <BooleanInput source="food_help" />
                    <BooleanInput source="health_issues" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="N.members" source="number_of_members" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="N.minors" source="number_of_minor_members" />
                </Grid>
                <Grid item xs={12}>
                    <NumberInput label="N.olders" source="number_of_older_members" />
                </Grid>
            </Grid>
        </SimpleForm>
    </Create>
);


export const HouseEdit = (props) => (
  <SimpleForm>
      <h2>Datos del Responsable</h2>
      <TextInput label="Nombre del responsable" source="responsible_name" />
      <TextInput label="Apellido del responsable" source="responsible_surname" />
      <TextInput label="DNI del responsable" source="responsible_dni" />
      <TextInput label="Teléfono del responsable" source="responsible_phone" />
      <h2>Datos del Hogar</h2>
      <TextInput label="Calle" source="address_street" />
      <NumberInput label="Número" source="address_number" />
      <TextInput label="Barrio" source="address_neighborhood" />
      <TextInput label="Entre calles" source="address_between_streets" />
      <TextInput label="Locality" source="address_locality" />
      <NumberInput source="lat" />
      <NumberInput source="long" />
      <h2>Integrantes del hogar</h2>
      <NumberInput label="Canidad de integrantes" source="number_of_members" />
      <NumberInput label="Cantidad de menores en el hogar" source="number_of_minor_members" />
      <NumberInput label="Cantidad de adultos en el hogar" source="number_of_older_members" />
      <BooleanInput label="¿Algún problema de salud" source="healh_issues" />
      <h2>Ingresos</h2>
      <BooleanInput label="¿Recibe Ingresos de la economía formal?" source="earnings_formal_economy" />
      <BooleanInput label="¿Se vieron afectados sus ingresos por el Aislamiento Preventivo Obligatorio?" source="earnings_affected_isolation" />
      <BooleanInput label="¿Recibe IFE?" source="family_emergency_plan" />
      <BooleanInput label="¿Es beneficiarie de algún plan social?" source="benefited_by_social_plan" />
      <h2>Necesidades</h2>
      <BooleanInput label="¿Retira bolsón de comida en alguna institución educativa o municipal cercana a su domicilio?" source="attends_community_dining_room" />
      <BooleanInput label="¿Asiste a algún comedor?" source="food_help" />
  </SimpleForm>
)

export const HouseEdit1 = (props) => (
    <Edit {...props}>
         <SimpleForm>
            <Grid container spacing={1}>
                <Grid item xs={6}>
                    <TextInput label="A.between" source="address_between_streets" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="A.locality" source="address_locality"  />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="A.nhood" source="address_neighborhood" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="A.number" source="address_number" />
                </Grid>
                <Grid item xs={12}>
                    <TextInput label="A.street" source="address_street" />
                </Grid>
                <Grid item xs={12}>
                <BooleanInput
                    source="benefied_by_social_plan"
                />
                <BooleanInput
                    source="attends_community_dining_room"
                />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput source="lat" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput source="long" />
                </Grid>
                <Grid item xs={12}>
                    <BooleanInput source="earnings_affected_isolation" /> 
                    <BooleanInput source="earnings_formal_economy" />
                    <BooleanInput source="family_emergency_plan" />
                    <BooleanInput source="food_help" />
                    <BooleanInput source="health_issues" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="N.members" source="number_of_members" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="N.minors" source="number_of_minor_members" />
                </Grid>
                <Grid item xs={12}>
                    <NumberInput label="N.olders" source="number_of_older_members" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="Resp. dni" source="responsible_dni" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="Resp name" source="responsible_name" />
                </Grid>
                <Grid item xs={6}>
                    <TextInput label="Resp. surn" source="responsible_surname" />
                </Grid>
                <Grid item xs={6}>
                    <NumberInput label="Resp. phone" source="responsible_phone" />
                </Grid>
            </Grid>
        </SimpleForm>
    </Edit>
);
