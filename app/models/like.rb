class Like < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  def self.ignore_index(index)
    from("#{self.table_name} IGNORE INDEX(#{index})")
  end
end
