import React, { useState } from 'react'
import { Button } from '../../../stories/Button';

function pageC() {
  const [value, setValue] = useState(0);

  return (
    <>
      <div>Page C</div>
      <div>Value: {value}</div>
      <Button
        label='Increment'
        onClick={() => setValue(value + 1)}
        primary={undefined}
        backgroundColor={undefined}
        size={undefined}
      />
    </>
  )
}

export default pageC