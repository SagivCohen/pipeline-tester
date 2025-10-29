import React, { useState } from 'react'

function pageC() {
  const [value, setValue] = useState(0);

  return (
    <>
      <div>Page C</div>
      <div>Value: {value}</div>
      <button onClick={() => setValue(value + 1)}>Increment</button>
    </>
  )
}

export default pageC