import React, { useState } from 'react'
import { useZipCodes } from '../../hooks/useZipCodes'
import CustomFieldsForm from './CustomFieldsForm'

export default function BuildingNew({ client }) {
  const [building, setBuilding] = useState(() => ({
    address: '',
    zip_code_id: '',
    client_id: client.id,
    custom_values: {}
  }))

  const [submitError, setSubmitError] = useState(null)

  const { zipCodes, loading, error } = useZipCodes()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSubmitError(null)
    
    try {
      const response = await fetch('/api/buildings', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ building: { ...building } })
      })

      if (response.ok) {
        setBuilding({
          address: '',
          zip_code_id: '',
          custom_values: {}
        })
      } else {
        const data = await response.json()
        setSubmitError(data.errors)
      }
    } catch (error) {
      setSubmitError('Failed to create building')
    }
  }

  const handleChange = (e) => {
    const { name, value } = e.target
    setBuilding(prev => ({
      ...prev,
      [name]: value
    }))
  }

  if (loading) return <div>Loading zip codes...</div>
  if (error) return <div>Unable to load zip codes: {error}</div>

  return (
    <div>
      <h1>New Building</h1>
      {submitError && (
        <div className="error">{submitError}</div>
      )}
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="address">Address:</label>
          <input
            id="address"
            type="text"
            name="address"
            value={building.address}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="zip_code_id">Zip Code:</label>
          <select 
            id="zip_code_id"
            name="zip_code_id" 
            value={building.zip_code_id} 
            onChange={handleChange}
            required
          >
            <option value="">Select a zip code</option>
            {zipCodes.map(zip => (
              <option key={zip.id} value={zip.id}>
                {zip.code} - {zip.city} - {zip.state.name}
              </option>
            ))}
          </select>
        </div>
        {client.custom_fields?.length > 0 && (
          <CustomFieldsForm 
            customFields={client.custom_fields}
            onSubmit={(values) => {
              setBuilding(prev => ({
                ...prev,
                custom_values: values
              }))
            }}
          />
        )}
        <button type="submit">Create Building</button>
      </form>
    </div>
  )
}
