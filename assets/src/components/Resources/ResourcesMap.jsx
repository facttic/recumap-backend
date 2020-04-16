import React, { useState, useEffect } from 'react';
import { baseUrl } from '../../providers/index'
import 'leaflet/dist/leaflet.css';
import axios from 'axios'
import { Card, CardHeader } from '@material-ui/core';
import NodesMap from '../Map/Map';

const ResourcesMap = () => {
    
    const [resources, setResources] = useState([]);

    async function fetchList(resource) {
        const url = `${baseUrl}/${resource}`;
        const { token } = localStorage.getItem('token')
        const headers = {}
        await axios.get(url, { headers })
            .then(res => {
              console.log('GET LIST :: ', res)
              setResources(res.data.data)
            })
    }

    useEffect(() => {
        fetchList('resources');
    }, [])

    return (
            <div>
                <Card>
                    <CardHeader title="Mapa de recursos"/>
                </Card>
                <NodesMap nodeType='resource' nodeList={resources}></NodesMap>
              
            </div>
        );
    }


export default ResourcesMap;
