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
      error: null,
      pagination: {
        current_page: 1,
        total_pages: 1,
        total_count: 1
      },
      setPage: jest.fn()
    });
  });

  it('renders buildings list correctly', () => {
    render(<Buildings client={mockClient} />);
    
    expect(screen.getByText('Buildings for Test Client')).toBeInTheDocument();
    expect(screen.getByText('123 Test St')).toBeInTheDocument();
    expect(screen.getByText('Test Value')).toBeInTheDocument();
  });
}); 