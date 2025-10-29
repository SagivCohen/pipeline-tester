import { render, screen } from '@testing-library/react'
import PageA from '../pageA'

const renderComponent = () => {
  render(<PageA />)
}

describe('Page A', () => {
  it('renders hello world text', () => {
    renderComponent();
    expect(screen.getByText(/Page A/i)).toBeInTheDocument()
  })
})