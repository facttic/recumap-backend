import React, { useState } from "react";
import { connect } from "react-redux";
import { UserMenu, MenuItemLink } from "react-admin";
import Avatar from "@material-ui/core/Avatar";

import { VpnKey, Person } from "@material-ui/icons";

const AppUserMenuView = props => {

  const [user, setUser] = useState({ id: 1, name: "test" });
  // const [permissions, setPermissions] = useState(null);
  // const [isLogged, setIsLogged] = useState(true);

  // useEffect(() => {
  //   const jwt = getJwtData();

  //   const resp = await DataProvider(GET_ONE, "users", { id: jwt.sub });

  //   setUser( resp.data );
  // }, [dataProvider, getJwtData, setUser]);


  // <MenuItemLink
  //   to={`/users/${user.id}`}
  //   primaryText={user.name}
  //   leftIcon={<Person />}
  // />
  // <MenuItemLink
  //   to="/change-password"
  //   primaryText="Modificar Contraseña"
  //   leftIcon={<VpnKey />}
  // />

  return (
    <UserMenu
      {...props}
      icon={
        user.picture && (
          <Avatar
            className="imageProfile"
            size={40}
            style={{ width: 40, height: 40 }}
            src={user.picture.src}
          />
        )
      }
    >
    </UserMenu>
  );

}

const mapStateToProps = state => {
  const resource = "profile";
  const id = "change-password";

  return {
    profile: state.admin.resources[resource]
      ? state.admin.resources[resource].data[id]
      : null
  };
};

const AppUserMenu = connect(mapStateToProps)(AppUserMenuView);
export default AppUserMenu;
