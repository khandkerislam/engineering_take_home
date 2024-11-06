import React from 'react';
import { useBuildings } from '../../hooks/useBuildings';

export default function Buildings({ client }) {
  const { buildings, loading, error } = useBuildings(client.id);

  const getBuildingCustomFields = (building) => {
    const { id, client_name, address, ...rest } = building;
    return Object.entries(rest);
  };

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  return (
    <div className="buildings">
      <div className="buildings-header">
        <h1>Buildings for {client.name}</h1>
      </div>
      
      <div className="buildings-grid">
        {buildings.map(building => (
          <div key={building.id} className="building-card">
            <h2>Building Details</h2>
            <p>Address: {building.address}</p>
            {getBuildingCustomFields(building).map(([key, value]) => (
              <p key={key}>{key}: {value}</p>
            ))}
          </div>
        ))}
      </div>
    </div>
  );
} 