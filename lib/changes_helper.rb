module ChangesHelper
  # Public: Filters the change items out.  If a version is given, show only the
  # items related to that version.
  #
  # version - Optional String version key.
  #
  # Returns an Array of the first 30 Nanoc::Item objects, sorted in reverse
  # chronological order.
  def api_changes(version = nil)
    changes = @items.select { |item| item[:kind] == 'change' }
    if version
      version_s = version.to_s
      changes.select { |item| item[:api_version] == version_s }
    else
      changes
    end.sort! do |x, y|
      attribute_to_time(y[:created_at]) <=> attribute_to_time(x[:created_at])
    end.first(30)
  end
end
