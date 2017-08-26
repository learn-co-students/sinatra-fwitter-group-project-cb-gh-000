module Slugifiable
  module InstanceMethods
    def slug
      slug = username.downcase
      slug.gsub!(/[^0-9A-Za-z\s]/, '')
      slug.gsub!(/[\s]/, '-')
      slug
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      all.find { |item| item.slug == slug }
    end
  end
end
