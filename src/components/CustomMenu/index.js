import React, { useState } from "react";
import { connect } from "react-redux";
import compose from "recompose/compose";
import { withRouter } from "react-router-dom";
import {
  translate,
  DashboardMenuItem,
  MenuItemLink
} from "react-admin";
import { Face } from "@material-ui/icons";
import MapIcon from '@material-ui/icons/Map';
import SubMenu from "./SubMenu";

const Menu = props => {
  const { onMenuClick, open } = props;
  const [menuUsuarios, setMenuUsuarios] = useState(true);
  const [menuMapa, setMenuMapa] = useState(true);

  return (
    <div>
      <DashboardMenuItem onClick={onMenuClick} style={{ width: "300px" }} />
      <SubMenu
        handleToggle={() => setMenuUsuarios(!menuUsuarios)}
        isOpen={menuUsuarios}
        sidebarIsOpen={open}
        icon={<Face />}
        name="Usuarios"
      >
        <MenuItemLink
          to="/users"
          primaryText="Administrador"
          onClick={onMenuClick}
        />
      </SubMenu>
      <SubMenu
        handleToggle={() => setMenuMapa(!menuMapa)}
        isOpen={menuMapa}
        sidebarIsOpen={open}
        name="Mapa"
        icon={<MapIcon />}
      >
        <MenuItemLink
          to="/points"
          primaryText="Puntos"
          onClick={onMenuClick}
        />
      </SubMenu>
    </div>
  );
}


const mapStateToProps = state => ({
  open: state.admin.ui.sidebarOpen,
  theme: state.theme
});

const enhance = compose(withRouter, connect(mapStateToProps, {}), translate);

export default enhance(Menu);
