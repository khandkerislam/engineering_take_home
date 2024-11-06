import React, { useState } from 'react'
import { useZipCodes } from '../../hooks/useZipCodes'
import CustomFieldsForm from './CustomFieldsForm'
import './BuildingForm.css'
export default function BuildingForm({ client, existingBuilding = null }) {
  const isEditMode = existingBuilding !== null
  const [building, setBuilding] = useState(() => {
    if (existingBuilding) {
      const { id, client_name, address, ...customFields } = existingBuilding
      return {
        id,
        address: address || '',
        zip_code_id: '', 
        client_id: client.id,
        custom_values: customFields || {}
      }
    }
    
    return {
      address: '',
      zip_code_id: '',
      client_id: client.id,
      custom_values: {}
    }
  })

  const [submitError, setSubmitError] = useState(null)
  const { zipCodes, loading, error } = useZipCodes()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSubmitError(null)
    
    try {
      const url = isEditMode 
        ? `/api/buildings/${existingBuilding?.id}` 
        : '/api/buildings'

      const response = await fetch(url, {
        method: isEditMode ? 'PUT' : 'POST',
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
      setSubmitError(`Failed to ${isEditMode ? 'update' : 'create'} building`)
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
      <h1>{isEditMode ? 'Edit Building' : 'New Building'}</h1>
      {submitError && (
        <div className="error">{submitError}</div>
      )}
      <form onSubmit={handleSubmit}>
        <div className="form-group">
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
        <div className="form-group">
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
            initialValues={building.custom_values}
            onSubmit={(values) => {
              setBuilding(prev => ({
                ...prev,
                custom_values: values
              }))
            }}
          />
        )}
        <button type="submit" className="submit-button">
          {isEditMode ? 'Update' : 'Create'} Building
        </button>
      </form>
    </div>
  )
}
