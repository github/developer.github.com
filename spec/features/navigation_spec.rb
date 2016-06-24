require 'spec_helper'

describe 'Navigation', js: true do
  it 'expands the sidebar properly' do
    visit "/v3/misc/"
    expect(page).to have_css('.js-current')
    expect(page.first(:css, '.js-current').text).to match('Miscellaneous')
  end

end
