import { render, screen } from '@testing-library/react'
import PageB from '../pageB'

const renderComponent = () => {
  render(<PageB />)
}

describe('Page B', () => {
  it('renders hello world text', () => {
    renderComponent();
    expect(screen.getByText(/Page B/i)).toBeInTheDocument()
  })
})