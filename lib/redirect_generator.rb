module RedirectGenerator
  def generate_redirects(redirects)
    redirects.each do |pairs|
      pairs.each_pair do |old_url, new_url|
        @items.create(
          "<%= renderp '/redirect.*',
            { :new_url => '#{new_url}' }
          %>",
          {},
          old_url.to_s.sub(/\/$/, '')
        )
      end
    end
  end
end

include RedirectGenerator
