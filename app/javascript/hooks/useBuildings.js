import { useState, useEffect } from 'react';

export const useBuildings = (clientId) => {
  const [buildings, setBuildings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchBuildings = async () => {
      try {
        setLoading(true);
        const response = await fetch(`/api/buildings?client_id=${clientId}`);
        if (!response.ok) throw new Error('Failed to fetch buildings');
        const data = await response.json();
        setBuildings(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    if (clientId) {
      fetchBuildings();
    }
  }, [clientId]);

  return { buildings, loading, error };
}; 