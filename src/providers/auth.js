// import decodeJwt from 'jwt-decode';

export default (baseUrl) => {
  // Should be refactored outside auth provider
  const parseResponse = (response) => response.data

  return {
    login: ({ username, password }) => {
      const request = new Request(`${baseUrl}/session`, {
        method: 'POST',
        body: JSON.stringify({ user: { email: username, password } }),
        headers: new Headers({
          'Content-Type': 'application/json'
        }),
      });
      return fetch(request)
      .then(response => {
        if (response.status < 200 || response.status >= 300) {
          throw new Error(response.statusText);
        }
        return response.json();
      })
      .then((response) => {
        const { token, renewal_token } = parseResponse(response)
        // const decodedToken = decodeJwt(token);
        localStorage.setItem('token', token);
        localStorage.setItem('renewal_token', renewal_token);
        // localStorage.setItem('permissions', decodedToken.permissions);
      });
    },
    logout: () => {
      localStorage.removeItem('token');
      localStorage.removeItem('permissions');
      return Promise.resolve();
    },
    checkError: error => {
      // ...
    },
    checkAuth: () => {
      return localStorage.getItem('token') ? Promise.resolve() : Promise.reject();
    },
    getPermissions: () => {
      const role = localStorage.getItem('permissions');
      return role ? Promise.resolve(role) : Promise.reject();
    }
  }
};
