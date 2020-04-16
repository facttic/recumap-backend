import { stringify } from 'query-string';
import axios from 'axios'

function getNamespace(resource) {
  const namespaces = {
    users: 'user',
    resources: 'resource',
    houses: 'house',
    orgs: 'org',
  }
  return namespaces[resource]
}

// houses is an authenticated service on those requests that use whitelist
const whitelist = ['orgs', 'resources']

export default (baseUrl) => {
  return {
    getList: (resource, params) => {
      const { page, perPage } = params.pagination;
      const { field, order } = params.sort;
      const query = {
        sort: JSON.stringify([field, order]),
        range: JSON.stringify([(page - 1) * perPage, page * perPage - 1]),
        filter: JSON.stringify(params.filter),
      };
      const url = `${baseUrl}/${resource}?${stringify(query)}`;
      let headers = {}
      if (resource === 'houses') {
        const token = localStorage.getItem('token')
        headers = {
          'Authorization': token,
        }
      }

      return axios.get(url, { headers })
      .then(res => {
        console.log('GET LIST :: ', res)
        return {
          data: res.data.data,
          total: res.data.data.length,
        }
      })
    },

    getOne: (resource, params) => {
      const url = `${baseUrl}/${resource}/${params.id}`
      const token = localStorage.getItem('token')
      const headers = {
        'Authorization': token
      }

      return axios.get(url, headers)
      .then(res => {
        console.log('GET ONE :: ', res)
        return { data: res.data.data }
      })
    },

    getMany: (resource, params) => {
      try {
        const query = {
          filter: JSON.stringify({ id: params.ids }),
        };
        const url = `${baseUrl}/${resource}?${stringify(query)}`;
        let headers = {}
        if (whitelist.indexOf(resource) !== -1) {
          const token = localStorage.getItem('token')
          headers = {
            'Authorization': token,
          }
        }
        return axios.get(url, { headers })
        .then(res => {
          console.log('GET MANY :: ', res)
          return { data: res.data.data, total: res.data.data.length }
        })
      } catch(err) {
        console.error('No permissions to fetch this resource')
      }
    },

    getManyReference: (resource, params) => {
      const { page, perPage } = params.pagination;
      const { field, order } = params.sort;
      const query = {
        sort: JSON.stringify([field, order]),
        range: JSON.stringify([(page - 1) * perPage, page * perPage - 1]),
        filter: JSON.stringify({
          ...params.filter,
          [params.target]: params.id,
        }),
      };
      const url = `${baseUrl}/${resource}?${stringify(query)}`;

      return axios.get(url)
      .then(res => {
        console.log('GET MANY REFERENCE :: ', res)
        return {
          data: res.data.data,
          total: res.data.data.length
        }
      })
    },

    update: (resource, params) => {
      const url = `${baseUrl}/${resource}/${params.id}`;
      const token = localStorage.getItem('token')
      const headers = {
        Authorization: token
      }

      return axios({
        method: 'PUT',
        url,
        headers,
        data: { [getNamespace(resource)]: params.data }
      })
      .then(res => {
        console.log('UPDATE :: ', res)
        return { data: res.data.data }
      })
    },

    updateMany: (resource, params) => {
      const query = {
        filter: JSON.stringify({ id: params.ids}),
      };
      const url = `${baseUrl}/${resource}?${stringify(query)}`

      const token = localStorage.getItem('token')
      const headers = {
        Authorization: token
      }

      return axios({
        data: { [getNamespace(resource)]: params.data },
        headers,
        method: 'PUT',
        url
      })
      .then(res => {
        console.log('UPDATE MANY :: ', res)
        return { data: res.data.data }
      })
    },

    create: (resource, params) => {
      const url = `${baseUrl}/${resource}`

      const token = localStorage.getItem('token')
      const headers = {
        Authorization: token
      }

      return axios({
        method: 'POST',
        url,
        headers,
        data: { [getNamespace(resource)]: params.data }
      })
      .then(res => {
        console.log('CREATE :: ', res)
        return { data: res.data.data }
      })
    },

    delete: (resource, params) => {
      const url = `${baseUrl}/${resource}/${params.id}`

      const token = localStorage.getItem('token')
      const headers = {
        Authorization: token
      }

      return axios({
        method: 'DELETE',
        headers,
        url,
      })
      .then(res => {
        console.log('DELETE :: ', res)
        return { data: { id: params.id } }
      })
    },

    deleteMany: (resource, params) => {
      const token = localStorage.getItem('token')
      const headers = {
        Authorization: token
      }

      const promises = params.ids.map(id => {
        return new Promise((resolve, reject) => {
          const url = `${baseUrl}/${resource}/${id}`
          resolve(
            axios({ method: 'DELETE', headers, url})
            .then(res => id)
          )
        })
      })
      console.log('DELETE MANY ::: ', resource, params)
      return Promise.all(promises)
      .then(values => {
        return { data: values }
      })
    }
  };
}
