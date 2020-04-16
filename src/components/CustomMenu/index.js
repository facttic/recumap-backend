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
  const [menuMapa, setMenuMapa] = useState(true);
  const [menuRecursos, setMenuRecursos] = useState(true);
  const [orgsMenu, setOrgsMenu] = useState(true);

  return (
    <div>
      <DashboardMenuItem onClick={onMenuClick} style={{ width: "300px" }} />
      <SubMenu
        handleToggle={() => setMenuRecursos(!menuRecursos)}
        isOpen={menuRecursos}
        sidebarIsOpen={open}
        icon={<Face />}
        name="Recursos"
      >
        <MenuItemLink
          to="/resources"
          primaryText="Recursos"
          onClick={onMenuClick}
        />
         <MenuItemLink
          to="/resources/map"
          primaryText="Mapa de Recursos"
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
          to="/houses"
          primaryText="Hogares"
          onClick={onMenuClick}
        />
        <MenuItemLink
          to="/houses/map"
          primaryText="Mapa de hogares"
          onClick={onMenuClick}
        />
      </SubMenu>
      <SubMenu
        handleToggle={() => setOrgsMenu(!orgsMenu)}
        isOpen={orgsMenu}
        sidebarIsOpen={open}
        name="Organizaciones"
        icon={<MapIcon />}
      >
        <MenuItemLink
          to="/orgs"
          primaryText="Organizaciones"
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
