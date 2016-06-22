require 'spec_helper'

describe 'Page Redirects' do
  context 'without javascript' do
    it 'shows the redirect page' do
      visit '/changes/2012-9-5-watcher-api/'
      expect(page).to have_text('Click here if you are not redirected.')
    end
  end

  context 'with javascript', js: true do
    it 'understands a normal redirect' do
      visit '/changes/2012-9-5-watcher-api/'
      expect(page).to have_text('What used to be known as "Watching" is now "Starring"')
    end
  end
end
