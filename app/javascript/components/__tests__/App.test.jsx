import React from 'react';
import { render, screen } from '@testing-library/react';
import App from '../App';
import { useClients } from '../../hooks/useClients';

jest.mock('../../hooks/useClients');

describe('App', () => {
  it('shows loading state', () => {
    useClients.mockReturnValue({
      loading: true,
      error: null,
      clients: []
    });

    render(<App />);
    expect(screen.getByText('Loading...')).toBeInTheDocument();
  });

  it('shows error state', () => {
    useClients.mockReturnValue({
      loading: false,
      error: 'Failed to fetch',
      clients: []
    });

    render(<App />);
    expect(screen.getByText('Error: Failed to fetch')).toBeInTheDocument();
  });
}); 