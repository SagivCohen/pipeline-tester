import React, { useState } from 'react'
import { Button } from '../../components/Button/Button';

function pageA() {
  const [value, setValue] = useState(0);

  return (
    <>
      <div>Page A</div>
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

export default pageA