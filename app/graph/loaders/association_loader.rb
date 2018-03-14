class AssociationLoader < GraphQL::Batch::Loader
  def initialize(association)
    @association = association
  end

  def perform(records)
    ActiveRecord::Associations::Preloader.new.preload(records, @association)
    records.each { |user| fulfill(user, nil) }
  end
end
