import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import Clients from '../Clients';

describe('Clients', () => {
  const mockClient = {
    id: 1,
    name: 'Test Client',
    buildings: [{ id: 1 }]
  };

  const mockProps = {
    clients: [mockClient],
    onSelectClient: jest.fn(),
    setAction: jest.fn(),
    pagination: {
      current_page: 1,
      total_pages: 1,
      total_count: 1
    }
  };

  it('renders client name and buttons', () => {
    render(<Clients {...mockProps} />);
    
    expect(screen.getByText('Test Client')).toBeInTheDocument();
    expect(screen.getByText('Buildings (1)')).toBeInTheDocument();
    expect(screen.getByText('Add Building')).toBeInTheDocument();
  });

  it('handles Buildings button click correctly', () => {
    render(<Clients {...mockProps} />);
    
    fireEvent.click(screen.getByText('Buildings (1)'));
    expect(mockProps.setAction).toHaveBeenCalledWith(0);
    expect(mockProps.onSelectClient).toHaveBeenCalledWith(mockClient);
  });

  it('handles Add Building button click correctly', () => {
    render(<Clients {...mockProps} />);
    
    fireEvent.click(screen.getByText('Add Building'));
    expect(mockProps.setAction).toHaveBeenCalledWith(1);
    expect(mockProps.onSelectClient).toHaveBeenCalledWith(mockClient);
  });
}); 