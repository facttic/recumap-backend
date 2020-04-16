import createAuthProvider from './auth'
import createDataProvider from './data'

const { REACT_APP_API_URL } = process.env

//const baseUrl = `${REACT_APP_API_URL}/api`
const baseUrl = `http://localhost:4000/api`

const AuthProvider = createAuthProvider(baseUrl)
const DataProvider = createDataProvider(baseUrl)

export {
  AuthProvider,
  DataProvider,
  baseUrl
}
  