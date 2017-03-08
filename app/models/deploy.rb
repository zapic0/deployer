class Deploy < ActiveRecord::Base
  has_and_belongs_to_many :issues

  validates :project, :date, :start_time, :estimated_end_time, :release_notes, presence: true

  def deploy_params
    params.require(:deploy).permit(:affected_projects, :release_notes, {:issue_ids => []}, :approved, :date, :start_time, :estimated_end_time, :authorization)
  end

end