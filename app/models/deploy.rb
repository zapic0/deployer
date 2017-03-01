class Deploy < ActiveRecord::Base
 has_and_belongs_to_many :issues

 validates :project, :date, :start_time, :estimated_end_time, :release_notes, :affected_projects, :authorization, presence: true


end