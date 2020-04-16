import React, { useState, useEffect } from 'react';
import './Map.css';
import L from 'leaflet';
import LCG from 'leaflet-control-geocoder'; //necesaria
import 'leaflet/dist/leaflet.css';
import { Map, TileLayer, Marker, Popup, Tooltip } from 'react-leaflet';

import icon from 'leaflet/dist/images/marker-icon.png';
import iconShadow from 'leaflet/dist/images/marker-shadow.png';
import NodeData from '../Nodes/NodesData'

const NodesMap = props => {
    const { nodeType, nodeList } = props;
    const [nodes, setNodes] = useState([]);
    const [actualNode, setActualNode] = useState();
    
    useEffect(() => {
        setNodes(nodeList)
    }, [nodeList])

    const map = React.createRef();

    const parseNodeAddress = (position, callback) => {
        const geo = {lat: position.lat, lng: position.long};
        const geocoder = L.Control.Geocoder.nominatim();
        let address;
        geocoder.reverse(geo, 10, results => {
            let r = results[0];
            address = r.name
            callback(address)
        }) 
    }

    // const addMarker = (e) => {
    //     // markers.pop();
    //     // const newNode = {
    //     //     geo: e.latlng,
    //     // }

    //     // setNodes(nodes.concat(newNode))  
    // }

    let DefaultIcon = L.icon({
        iconUrl: icon,
        shadowUrl: iconShadow
    });
    
    L.Marker.prototype.options.icon = DefaultIcon;

    
 
    return (
            <div>
                <Map
                //Capa principal del mapa que controla el zoom, bordes y el centro
                    center={[-34.5875, -58.4477]}
                    // onClick={addMarker}
                    zoom={13}
                    ref= {map}
                    maxZoom={18}
                    minZoom={5}   
                    style={{width: '100%',height: '400px'}}
                >
                    <TileLayer
                        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                        url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
                    />
                    {nodes.map((position, idx) =>

                         <Marker 
                             key={`marker-${idx}`}
                             position={[position.lat, position.long]} 
                             onClick={() => { 
                                setActualNode(position);
                             }}>
                           
                            <Tooltip> <span>{position.name}</span></Tooltip>
                         </Marker>
                       
                    )}
                </Map>
                { actualNode && (
                    <NodeData formtype={nodeType} node={actualNode} parseAddressFunction={parseNodeAddress}></NodeData>
                  ) 
                }
            </div>
        );
    }


export default NodesMap;
