import { useState, useEffect } from 'react'

export const useClients = () => {
  const [clients, setClients] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    const fetchClients = async () => {
      try {
        const response = await fetch('/api/clients')
        if (response.ok) {
          const data = await response.json()
          setClients(data)
        } else {
          setError('Failed to load clients')
        }
      } catch (error) {
        setError('Failed to load clients')
      } finally {
        setLoading(false)
      }
    }

    fetchClients()
  }, [])

  return { clients, loading, error }
} 