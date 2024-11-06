import { useState, useEffect } from 'react'

export const useClients = () => {
  const [clients, setClients] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 0,
    totalCount: 0,
    perPage: 10
  });

  const fetchClients = async (page = 1) => {
    try {
      setLoading(true);
      const response = await fetch(`/api/clients?page=${page}`)
      if (!response.ok) throw new Error('Failed to fetch clients');

      const data = await response.json()
      setClients(data.clients)
      setPagination({
        currentPage: data.meta.current_page,
        totalPages: data.meta.total_pages,
        totalCount: data.meta.total_count,
        perPage: data.meta.per_page
      })
    } catch (error) {
      setError(error.message)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchClients(1)
  }, [])

  return { 
    clients, 
    loading, 
    error, 
    pagination, 
    fetchPage: fetchClients 
  }
} 