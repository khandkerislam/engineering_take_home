import React, { useState } from 'react'

export default function CustomFieldsForm({ customFields, onSubmit }) {
  const [customValues, setCustomValues] = useState({})

  const handleChange = (e) => {
    const { name, value } = e.target
    setCustomValues(prev => ({
      ...prev,
      [name]: value
    }))
    onSubmit({ 
      ...customValues,
      [name]: value
    })
  }

  const renderField = (field) => {
    console.log(field)
    switch (field.field_type) {
      case 'number':
        return (
          <input
            id={field.name}
            type="number"
            name={field.name}
            value={customValues[field.name] || ''}
            onChange={handleChange}
          />
        )
      
      case 'list':
        return (
          <div className="radio-group">
            {field.enum_options.map(option => (
              <label key={option} className="radio-label">
                <input
                  type="radio"
                  name={field.name}
                  value={option}
                  checked={customValues[field.name] === option}
                  onChange={handleChange}
                />
                {option}
              </label>
            ))}
          </div>
        )
      
      default:
        return (
          <input
            id={field.name}
            type="text"
            name={field.name}
            value={customValues[field.name] || ''}
            onChange={handleChange}
          />
        )
    }
  }

  return (
    <div className="custom-fields">
      {customFields.map(field => (
        <div key={field.name} className="field-container">
          <label htmlFor={field.name}>{field.name}:</label>
          {renderField(field)}
        </div>
      ))}
    </div>
  )
} 