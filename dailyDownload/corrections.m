function nodeData = corrections(nodeID,nodeData)

    switch nodeID
     
        case "001e0610c040" 
            nodeData.gps_altitude(:)  =  224.9 ; 
            nodeData.gps_latitude(:)  =  35.0427;
            nodeData.gps_longitude(:) = -85.3057;

        case "001e0610c2e5"
            nodeData.gps_altitude(:)  =  219;
            nodeData.gps_latitude(:)  =  33.027222; 
            nodeData.gps_longitude(:) = -96.750639;

    end
    
end

