class DeploysController < ApplicationController
  before_action :load_project


  def index
    @deploys = Deploy.where(project: params[:project_id])

    @project_id = params[:project_id]
    @deploys ||= {}
  end

  def new
    @deploy = Deploy.new
    @project_issues = @project.issues
  end

  def show
    load_deploy
  end

  def edit
    load_deploy
  end

  def create
    deploy_name = Time.now.strftime('%Y%M%d%H%M')
    deploy_params = params[:deploy].permit(:affected_projects, :release_notes)
    deploy_params[:deploy_name] = deploy_name
    deploy_params[:date] = Date.today
    deploy_params[:start_time] = Time.now
    deploy_params[:project] = params[:project_id]
    deploy = Deploy.create(deploy_params)
    deploy.deploy_name = deploy_name

    deploy.save!

    redirect_to action: :index
  end


  private

  def load_deploy
    @deploy = Deploy.find_by_id(params[:id])
    @project_issues = @project.issues
  end

  def load_project
    @project = Project.find_by(identifier: params[:project_id])
  end

end
