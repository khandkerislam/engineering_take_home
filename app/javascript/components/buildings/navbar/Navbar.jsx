import React from 'react';
import './Navbar.css';

export default function Navbar() {

    const handleHomeClick = () => {
        window.location.href = '/';
        window.location.reload();
    }

    return (
      <nav className="navbar">
        <button onClick={handleHomeClick} className="home-link">
            Home
        </button>      
      </nav>
    );
  }