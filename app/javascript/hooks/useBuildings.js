import { useState, useEffect } from 'react';

export const useBuildings = (clientId) => {
  const [buildings, setBuildings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 0,
    totalCount: 0,
    perPage: 10
  });

  const fetchBuildings = async (page = 1) => {
    try {
      setLoading(true);
      const response = await fetch(`/api/buildings?client_id=${clientId}&page=${page}`);
      if (!response.ok) throw new Error('Failed to fetch buildings');
      
      const data = await response.json();
      setBuildings(data.buildings);
      setPagination({
        currentPage: data.meta.current_page,
        totalPages: data.meta.total_pages,
        totalCount: data.meta.total_count,
        perPage: data.meta.per_page
      });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (clientId) {
      fetchBuildings(1);
    }
  }, [clientId]);

  return { 
    buildings, 
    loading, 
    error,
    pagination,
    fetchPage: fetchBuildings
  };
};