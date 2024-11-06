import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import CustomFieldsForm from '../CustomFieldsForm';

describe('CustomFieldsForm', () => {
  const mockOnSubmit = jest.fn();

  const sampleFields = [
    { name: 'textField', field_type: 'text' },
    { name: 'numberField', field_type: 'number' },
    { 
      name: 'listField', 
      field_type: 'list', 
      enum_options: ['Option1', 'Option2'] 
    }
  ];

  beforeEach(() => {
    mockOnSubmit.mockClear();
  });

  it('renders all fields correctly', () => {
    render(<CustomFieldsForm customFields={sampleFields} onSubmit={mockOnSubmit} />);

    expect(screen.getByLabelText('textField:')).toBeInTheDocument();
    expect(screen.getByLabelText('numberField:')).toBeInTheDocument();
    expect(screen.getByLabelText('Option1')).toBeInTheDocument();
  });
}); 