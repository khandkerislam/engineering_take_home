import { useState, useEffect } from 'react'

export const useZipCodes = () => {
  const [zipCodes, setZipCodes] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    const fetchZipCodes = async () => {
      try {
        const response = await fetch('/api/zip_codes')
        if (response.ok) {
          const data = await response.json()
          setZipCodes(data)
        } else {
          setError('Failed to load zip codes')
        }
      } catch (error) {
        setError('Failed to load zip codes')
      } finally {
        setLoading(false)
      }
    }

    fetchZipCodes()
  }, [])

  return { zipCodes, loading, error }
} 