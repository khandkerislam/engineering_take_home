import React, { useState } from 'react';
import Clients from './clients/Clients';
import Buildings from './buildings/Buildings';
import BuildingForm from './buildings/BuildingForm';
import { useClients } from '../hooks/useClients';
import Navbar from './buildings/navbar/Navbar';

export default function App() {
  const { clients, loading, error } = useClients();
  const [selectedClient, setSelectedClient] = useState(null);
  const [action, setAction] = useState(0);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div className="app">
      <Navbar />
      {selectedClient ? (
        action === 0 ? (
          <Buildings 
            client={selectedClient} 
          />
        ) : (
          <BuildingForm
            client={selectedClient}
          />
        )
      ) : (
        <Clients 
          clients={clients} 
          onSelectClient={setSelectedClient}
          setAction={setAction}
        />
      )}
    </div>
  );
} 