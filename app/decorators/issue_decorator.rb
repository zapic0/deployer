Redmine::Issue.class_eval do
  has_and_belongs_to_many :deploys
end