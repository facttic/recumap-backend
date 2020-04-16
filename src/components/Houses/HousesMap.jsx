import React, { useState, useEffect } from 'react';
import { baseUrl } from '../../providers/index'
import 'leaflet/dist/leaflet.css';
import axios from 'axios'
import { Card, CardHeader } from '@material-ui/core';
import NodesMap from '../Map/Map'

const HousesMap = () => {
    
    const [houses, setHouses] = useState([]);

    async function fetchList(resource) {
        const url = `${baseUrl}/${resource}`;
        const token   = localStorage.token;
        const headers = {
              'Authorization': token,
              'Access-Control-Expose-Headers': 'X-Total-Count'
            }
        await axios.get(url, { headers })
            .then(res => {
              console.log('GET LIST :: ', res)
              setHouses(res.data.data)
            })
    }

    useEffect(() => {
        fetchList('houses');
    }, [])

    return (
            <div>
                <Card>
                    <CardHeader title="Mapa de hogares"/>
                </Card>
                <NodesMap nodeType='house' nodeList={houses}></NodesMap>
              
            </div>
        );
    }


export default HousesMap;
