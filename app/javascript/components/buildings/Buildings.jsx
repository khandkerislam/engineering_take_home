import React, { useState } from 'react';
import { useBuildings } from '../../hooks/useBuildings';
import BuildingForm from './BuildingForm';
import './Buildings.css';
import Pagination from '../shared/Pagination';

export default function Buildings({ client }) {
  const { buildings, loading, error, pagination, fetchPage } = useBuildings(client.id);
  const [editBuilding, setEditBuilding] = useState(null)

  const getBuildingCustomFields = (building) => {
    const { id, client_name, address, ...rest } = building;
    return Object.entries(rest);
  };

  const onSuccess = () => {
    setEditBuilding(null);
    fetchPage(pagination.currentPage);
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
            {editBuilding?.id === building.id ? (
              <div className="edit-mode">
                <BuildingForm
                  client={client}
                  existingBuilding={building}
                  onSuccess={onSuccess}
                />
                <button 
                  onClick={() => setEditBuilding(null)}
                  className="cancel-button"
                >
                  Cancel
                </button>
              </div>
            ) : (
              <div className="view-mode">
                <h2>Building Details</h2>
                <div className="building-info">
                  <p className="address"><strong>Address:</strong> {building.address}</p>
                  {getBuildingCustomFields(building).map(([key, value]) => (
                    <p key={key} className="custom-field">
                      <strong>{key}:</strong> {value}
                    </p>
                  ))}
                </div>
                <button 
                  onClick={() => setEditBuilding(building)}
                  className="edit-button"
                >
                  Edit
                </button>
              </div>
            )}
          </div>
        ))}
      </div>
      {pagination.totalPages > 1 && (
        <Pagination
          currentPage={pagination.currentPage}
          totalPages={pagination.totalPages}
          onPageChange={fetchPage}
        />
      )}
    </div>
  )
}