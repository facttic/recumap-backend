// in src/MyLayout.js
import React from "react";
import { Layout } from "react-admin";
import AppBarComponent from "./AppBarComponent";
import Menu from "./components/CustomMenu";

const AppLayout = props => (
  <Layout {...props} appBar={AppBarComponent} menu={Menu} />
);

export default AppLayout;
