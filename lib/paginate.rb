class Nanoc::Item
  attr_accessor :page_items
  attr_accessor :page_parent
  attr_accessor :sub_pages

  def paginated?
    !page_items.nil? && !page_items.empty? && !page_parent.nil?
  end
end

module Paginate
  BLOG_TYPE = 'changes'

  def paginated_items(items)
    items.select { |i| i.identifier =~ %r(/#{BLOG_TYPE}/\d{4}) }.sort_by { |b| Time.parse(b[:created_at].to_s) }
  end

  def create_individual_blog_pages
    paginated_blog_items = paginated_items(items)

    # create individual blog pages
    blog_pages = []
    blog_pages << paginated_blog_items.slice!(0...PER_PAGE) until paginated_blog_items.empty?

    blog_pages.each_index do |i|
      next_i = i + 1 # accounts for 0-index array
      first = i * PER_PAGE
      last  = (next_i * PER_PAGE) - 1

      @items.create(
        "<%= renderp '/pagination_page.html',
          :current_page => #{next_i},
          :per_page => PER_PAGE,
          :first => #{first}, :last => #{last} %>",
        { :title => 'GitHub API Changes' },
        "/changes/#{next_i}"
      )
    end
  end
end

include Paginate
