import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import { Link, Route, Routes } from 'react-router-dom'
import PageA from './features/featureA/pageA'
import PageB from './features/featureB/pageB'
import PageC from './features/featureC/pageC'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <nav style={{ marginBottom: 20 }}>
        <Link to="/page-a" style={{ marginRight: 60 }}>Page A</Link>
        <Link to="/page-b" style={{ marginRight: 60 }}>Page B</Link>
        <Link to="/page-c">Page C</Link>
      </nav>

      <Routes>
        <Route path="/page-a" element={<PageA />} />
        <Route path="/page-B" element={<PageB />} />
        <Route path="/page-c" element={<PageC />} />
        <Route path="*" element={<p>Select an investigation from above.</p>} />
      </Routes>
    </>
  )
}

export default App
