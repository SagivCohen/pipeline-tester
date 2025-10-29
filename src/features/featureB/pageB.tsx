import React, { useState } from 'react'
import { Button } from '../../components/Button/Button';

function pageB() {
  const [value, setValue] = useState(0);

  return (
    <>
      <div>Page B</div>
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

export default pageB