# speed up rspec under ruby 1.9 because it doesn't work otherwise
if RUBY_VERSION > '1.9.2' and RUBY_ENGINE == 'ruby'
  class Object
    def to_ary ; nil ; end
    def to_hash ; nil ; end
  end

  class String
    def to_path ; self ; end
  end
end
