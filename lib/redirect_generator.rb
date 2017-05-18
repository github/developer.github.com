module RedirectGenerator
  def generate_redirects(redirects)
    redirects.each do |pairs|
      pairs.each_pair do |old_url, new_url|
        filename = old_url.to_s.sub(%r{/$}, '')
        @items.create(
          "<%= renderp '/redirect.*',
            { :new_url => '#{new_url}'
            }
          %>",
          { :filename => filename },
          filename
        )
      end
    end
  end
end

include RedirectGenerator
