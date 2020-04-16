import React from 'react'
import { Create, Edit,NumberInput, SimpleForm, DisabledInput, TextInput, DateInput, LongTextInput, ReferenceManyField, Datagrid, TextField, DateField, EditButton } from 'react-admin';
import RichTextInput from 'ra-input-rich-text';
export default () => (
    <SimpleForm>
      <TextInput source="title" />
      <TextInput source="teaser" options={{ multiLine: true }} />
      <TextInput source="teaser" options={{ multiLine: true }} />
      <DateInput label="Publication date" source="published_at" defaultValue={new Date()} />
      <RichTextInput source="body" />
      <NumberInput source="nb_views" />
    </SimpleForm>
)