import React from "react";
import { AppBar } from "react-admin";
import Typography from "@material-ui/core/Typography";
import { withStyles } from "@material-ui/core/styles";
import AppUserMenu from "./AppUserMenu"
import "./AppBarComponent.css";

const styles = {
  colorSecondary: {
    color: "yellow",
    backgroundColor: "green"
  },
  title: {},
  spacer: {
    flex: 1
  }
};

const AppBarComponent = withStyles(styles)(({ classes, ...props }) => (
  <AppBar {...props} userMenu={<AppUserMenu />}>
    <Typography
      variant="h6"
      color="inherit"
      className={classes.title}
      id="react-admin-title"
    />
    <span className={classes.spacer} />
  </AppBar>
));

export default AppBarComponent;
