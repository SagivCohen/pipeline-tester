import { render, screen } from '@testing-library/react'
import { Button } from '../../../../stories/Button'

const renderComponent = () => {
  render(<Button label="Increment" onClick={() => { }} />)
}

describe('Button', () => {
  it('renders the button with the correct label', () => {
    renderComponent();
    expect(screen.getByText(/Increment/i)).toBeInTheDocument()
  })
})