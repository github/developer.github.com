require 'spec_helper'

describe 'Blog Date' do
  it 'is not in the past' do
    posts.each do |post|
      matches = post.match(%r{(\d{4}-\d{2}-\d{2})-})
      next unless matches

      date = Date.parse matches[1]
      today_pst = Time.now.getlocal('-08:00')
      today_date = Date.parse(today_pst.strftime('%Y-%m-%d'))
      fail "#{post} has a date in the past." if date < today_date
    end
  end
end
