import React, { useState, useEffect } from 'react';
import { Card, CardContent, Typography, CardHeader } from '@material-ui/core';

const NodesData = props => {

    const { formType } = props;
    const [node, setNode] = useState(props.node);
    const [addressNode, setAddressNode] = useState();
    
    const parser = props.parseAddressFunction;

    useEffect(() => {
        setNode(props.node)
        parser(node, setAddressNode)
        console.log(node)
    }, [props.node])

    const renderResources = () => {
        return (
            <div>
                <Card>
                    <CardHeader title={node.name}/>
                    <CardContent>
                        <Typography color="textSecondary">
                            {node.responsible_name}
                        </Typography>
                        <Typography variant="body2" component="p">
                            {node.responsible_phone}
                        </Typography> 
                        <Typography variant="body2" component="p">
                            {addressNode}
                        </Typography> 
                        <Typography variant="body2" component="p">
                            {node.address_locality}
                        </Typography>   
                    </CardContent>
                </Card>
                
            </div>
        );
    }

    const renderHouses = () => {
        return (
            <div>
                 <Card>
                    <CardHeader title={node.responsible_name}/>
                    <CardContent>
                        <Typography variant="body2" component="p">
                            {node.responsible_phone}
                        </Typography> 
                        <Typography variant="body2" component="p">
                            {addressNode}
                        </Typography> 
                        <Typography variant="body2" component="p">
                            {node.address_locality}
                        </Typography>   
                    </CardContent>
                </Card>
            </div>
        );
    }

    return (
         <div>
            { formType === 'house'       
              ? renderHouses()
              : renderResources()      
            }
         </div>
    )
}

export default NodesData;
