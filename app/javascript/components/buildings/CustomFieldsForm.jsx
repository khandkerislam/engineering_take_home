import React, { useState, useEffect } from 'react'

export default function CustomFieldsForm({ customFields, initialValues = {}, onSubmit }) {
  const [customValues, setCustomValues] = useState(initialValues)

  useEffect(() => {
    setCustomValues(initialValues)
  }, [initialValues])

  const handleChange = (e) => {
    const { name, value, type } = e.target
    
    // Convert to number for number fields
    const processedValue = type === 'number' ? 
      (value === '' ? '' : parseFloat(value)) : value;
    
    const newValues = {
      ...customValues,
      [name]: processedValue
    }
    setCustomValues(newValues)
    onSubmit(newValues)
  }
  console.log(customValues)
  const renderField = (field) => {
    const value = customValues[field.name] ?? '' // Use nullish coalescing
    
    switch (field.field_type) {
      case 'number':
        return (
          <input
            id={field.name}
            type="number"
            name={field.name}
            value={value}
            onChange={handleChange}
            step="any" 
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
                  checked={value === option}
                  onChange={handleChange}
                />
                <span>{option}</span>
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
            value={value}
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