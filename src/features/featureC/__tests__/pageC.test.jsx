import { render, screen } from '@testing-library/react'
import PageC from '../pageC'

const renderComponent = () => {
  render(<PageC />)
}

describe('Page C', () => {
  it('renders hello world text', () => {
    renderComponent();
    expect(screen.getByText(/Page C/i)).toBeInTheDocument()
  })
})