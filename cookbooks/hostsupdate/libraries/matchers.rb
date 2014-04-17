if defined?(ChefSpec)
  def append_hostsupdate_entry(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hostsupdate_entry, :append, resource_name)
  end

  def create_hostsupdate_entry(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hostsupdate_entry, :create, resource_name)
  end

  def create_hostsupdate_entry_if_missing(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hostsupdate_entry, :create_if_missing, resource_name)
  end

  def remove_hostsupdate_entry(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hostsupdate_entry, :remove, resource_name)
  end

  def update_hostsupdate_entry(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hostsupdate_entry, :update, resource_name)
  end
end
