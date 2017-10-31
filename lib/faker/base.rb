module Faker
  class Base
    def initialize(default_count)
      @default_count = default_count
    end

    def create!(count: default_count)
      build(count: count).each(&:save!)
    end

    def create(count: default_count)
      build(count: count).each(&:save)
    end

    def build(count: default_count)
      count.times.map { build_record }
    end

    private

    def build_record
      raise NotImplementedError, "Please implement in subclass #{self.class.name}."
    end

    attr_reader :default_count
  end
end
