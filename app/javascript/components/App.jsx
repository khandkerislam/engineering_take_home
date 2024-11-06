import React, { useState } from 'react';
import Clients from './clients/Clients';
import Buildings from './buildings/Buildings';
import BuildingNew from './buildings/BuildingNew';
import { useClients } from '../hooks/useClients';

export default function App() {
  const { clients, loading, error } = useClients();
  const [selectedClient, setSelectedClient] = useState(null);
  const [view, setView] = useState(0);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div className="app">
      {selectedClient ? (
        view === 0 ? (
          <Buildings 
            client={selectedClient} 
          />
        ) : (
          <BuildingNew
            client={selectedClient}
          />
        )
      ) : (
        <Clients 
          clients={clients} 
          onSelectClient={setSelectedClient}
          setAction={setView}
        />
      )}
    </div>
  );
} 