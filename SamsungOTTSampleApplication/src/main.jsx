import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.jsx';

// PUBLIC_INTERFACE
function boot() {
  /** Bootstraps the React application by mounting the root component. */
  const container = document.getElementById('root');
  if (!container) {
    // Fail gracefully if root is missing
    console.error('Root element #root not found');
    return;
    }
  const root = createRoot(container);
  root.render(<App />);
}

boot();
