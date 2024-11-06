import React from 'react'
import { render, screen } from '@testing-library/react'
import Clients from '../Clients'
import { useClients } from '../../../hooks/useClients'

jest.mock('../../../hooks/useClients')

describe('Clients', () => {
  const mockClients = [
    {
      id: 1,
      name: 'Test Client 1',
      buildings: ['building1', 'building2'],
      custom_fields: ['field1', 'field2']
    },
    {
      id: 2,
      name: 'Test Client 2',
      buildings: ['building3'],
      custom_fields: null
    }
  ]

  it('renders loading state', () => {
    useClients.mockReturnValue({ loading: true, clients: [], error: null })
    render(<Clients />)
    expect(screen.getByText('Loading clients...')).toBeInTheDocument()
  })

  it('renders error state', () => {
    useClients.mockReturnValue({ loading: false, clients: [], error: 'Failed to fetch' })
    render(<Clients />)
    expect(screen.getByText('Error: Failed to fetch')).toBeInTheDocument()
  })

  it('renders clients grid with correct data', () => {
    useClients.mockReturnValue({ loading: false, clients: mockClients, error: null })
    render(<Clients />)

    expect(screen.getByText('Clients')).toBeInTheDocument()

    expect(screen.getByText('Test Client 1')).toBeInTheDocument()
    expect(screen.getByText('Test Client 2')).toBeInTheDocument()

    expect(screen.getByText('Buildings: 2')).toBeInTheDocument()
    expect(screen.getByText('Buildings: 1')).toBeInTheDocument()

    expect(screen.getByText('Custom Fields: 2')).toBeInTheDocument()
    expect(screen.getByText('Custom Fields: 0')).toBeInTheDocument()
  })
}) 