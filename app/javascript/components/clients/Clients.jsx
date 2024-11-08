import React from 'react';
import './Clients.css';
import Pagination from '../shared/Pagination';
export default function Clients({ clients, onSelectClient, setAction, pagination, fetchPage }) {
  const handleClientClick = (client, action ) => {
    setAction(action);
    onSelectClient(client);
  };

  return (
    <div className="clients">
      <h1 className="clients-title">Clients</h1>
      
      <div className="clients-grid">
        {clients.map(client => (
          <div 
            key={client.id} 
            className="client-card"
            role="button"
            tabIndex={0}
          >
            <h2>{client.name}</h2>
            <div className="client-details">
                <button 
                    onClick={(e) => {
                    e.stopPropagation();
                    handleClientClick(client, 0);
                    }}
                >
                    Buildings ({client.buildings.length})
                </button>
                <button 
                    onClick={(e) => {
                    e.stopPropagation();
                    handleClientClick(client, 1);
                    }}
                >
                    Add Building
                </button>
            </div>
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
  );
} 