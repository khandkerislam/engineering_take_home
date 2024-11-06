// Entry point for the build script in your package.json
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('react-root');
  if (node) {
    createRoot(node).render(<App />);
  }
});
