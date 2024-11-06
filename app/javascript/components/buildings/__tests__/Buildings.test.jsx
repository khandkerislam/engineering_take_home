import React from 'react';
import { render, screen } from '@testing-library/react';
import Buildings from '../Buildings';
import { useBuildings } from '../../../hooks/useBuildings';

jest.mock('../../../hooks/useBuildings');

describe('Buildings', () => {
  const mockClient = {
    id: 1,
    name: 'Test Client'
  };

  const mockBuildings = [
    {
      id: 1,
      address: '123 Test St',
      client_name: 'Test Client',
      customField: 'Test Value'
    }
  ];

  beforeEach(() => {
    useBuildings.mockReturnValue({
      buildings: mockBuildings,
      loading: false,
      error: null
    });
  });

  it('renders buildings list correctly', () => {
    render(<Buildings client={mockClient} />);
    
    expect(screen.getByText('Buildings for Test Client')).toBeInTheDocument();
    expect(screen.getByText('Address: 123 Test St')).toBeInTheDocument();
    expect(screen.getByText('customField: Test Value')).toBeInTheDocument();
  });
}); 