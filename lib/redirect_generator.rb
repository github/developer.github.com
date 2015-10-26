module RedirectGenerator
  def generate_redirects(redirects)
    redirects.each do |pairs|
      pairs.each_pair do |old_url, new_url|
        @items << Nanoc::Item.new(
          "<%= render 'redirect',
            { :new_url => '#{new_url}' }
          %>",
          {},
          old_url.to_s
        )
      end
    end
  end
end

include RedirectGenerator
