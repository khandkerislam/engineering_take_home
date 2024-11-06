import React from 'react'
import { useClients } from '../../hooks/useClients'

export default function Clients() {
  const { clients, loading, error } = useClients()
  console.log('All clients:', clients)  // This will log the entire clients array

  if (loading) return <div>Loading clients...</div>
  if (error) return <div>Error: {error}</div>

  return (
    <div className="clients">
      <h1>Clients</h1>
      
      <div className="clients-grid">
        {clients.map(client => (
          <div key={client.id} className="client-card">
            <h2>{client.name}</h2>
            <div className="client-details">
              <p>Buildings: {client.buildings.length}</p>
              <p>Custom Fields: {client.custom_fields?.length || 0}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
} 