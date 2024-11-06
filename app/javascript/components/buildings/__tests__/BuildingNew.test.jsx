import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import BuildingNew from '../BuildingNew';
import { useZipCodes } from '../../../hooks/useZipCodes';

jest.mock('../../../hooks/useZipCodes');

describe('BuildingNew', () => {
  const mockClient = {
    id: 1,
    name: 'Test Client',
    custom_fields: [
        { name: 'textField', field_type: 'text' }
    ]
  };

  const mockZipCodes = [
    { id: 1, code: '12345', city: 'Test City', state: { name: 'Test State' } }
  ];

  beforeEach(() => {
    useZipCodes.mockReturnValue({
      zipCodes: mockZipCodes,
      loading: false,
      error: null
    });
  });

  it('renders the form correctly', () => {
    render(<BuildingNew client={mockClient} />);
    
    expect(screen.getByLabelText('Address:')).toBeInTheDocument();
    expect(screen.getByLabelText('Zip Code:')).toBeInTheDocument();
    expect(screen.getByText('Create Building')).toBeInTheDocument();
    expect(screen.getByLabelText('textField:')).toBeInTheDocument();
  });
}); 