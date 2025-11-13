import React from 'react';

// PUBLIC_INTERFACE
export default function App() {
  /** Root application component rendered at startup. */
  return (
    <div
      style={{
        minHeight: '100dvh',
        display: 'grid',
        placeItems: 'center',
        background: '#121212',
        color: '#fff',
        fontFamily: 'system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, Noto Sans, Helvetica Neue, Arial, sans-serif'
      }}
    >
      <main style={{ textAlign: 'center' }}>
        <h1 style={{ margin: 0 }}>Samsung OTT Sample Application</h1>
        <p style={{ opacity: 0.8 }}>
          Vite + React scaffold is running on port 3000.
        </p>
      </main>
    </div>
  );
}
