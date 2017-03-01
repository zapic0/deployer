require_dependency 'project'

class Project < ActiveRecord::Base

  safe_attributes 'customers_deploys_notifications_emails', 'deploys_notifications_emails',
                  'abbreviation'

end