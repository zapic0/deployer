class DeploysController < ApplicationController
  before_action :load_project
  before_action :load_deploy, :except => [:index, :new]
  before_action :set_recipients, :only => [:send_start, :send_successful_end, :send_rollback]


  def index
    @deploys = Deploy.where(project: params[:project_id])

    @project_id = params[:project_id]
    @deploys ||= {}
  end

  def new
    @deploy = Deploy.new
    @deploy.date = Date.today
    @deploy.start_time = Time.current + 30.minutes
    @deploy.estimated_end_time = Time.current + 45.minutes
    @project_issues = @project.issues
  end

  def show
    load_author
    load_version
  end

  def send_start
    @deploy.state = "in_progress"
    @deploy.save

    Mailer::DeployerMailer.send_start(@deploy, @project, @recipients).deliver

    flash[:info] = t('.mails_sent')
    redirect_to action: :show, id: @deploy.id, project_id: @project.identifier
  end

  def send_successful_end
    @deploy.state = "finished"
    @deploy.save

    Mailer::DeployerMailer.send_successful_end(@deploy, @project, @recipients).deliver

    flash[:info] = t('.mails_sent')
    redirect_to action: :show, id: @deploy.id, project_id: @project.identifier
  end

  def send_rollback
    @deploy.state = "failed"
    @deploy.save

    Mailer::DeployerMailer.send_rollback(@deploy, @project, @recipients).deliver

    flash[:info] = t('.mails_sent')
    redirect_to action: :show, id: @deploy.id, project_id: @project.identifier
  end

  def edit
    unless params[:deploy].blank?
      deploy_params = load_from_params
      @deploy = Deploy.create(deploy_params)
    end
  end

  def update
    deploy_params = load_from_params
    @deploy.update_attributes(deploy_params)
    if(@deploy.save)
      flash[:info] = t('.deploy_updated')
      redirect_to action: :index
    else
      flash[:warning] = t('.error_saving_deploy')
      render action: :edit
    end
  end

  def create

    unless params[:deploy].blank?
      deploy_params = load_from_params
      @deploy = Deploy.create(deploy_params)
      @deploy.state = 'pending'
      @deploy.user_id = User.current.id
    end

    if(@deploy.save)
      flash[:info] = t('.new_deploy_created')
      redirect_to action: :show, id: @deploy.id, project_id: @project.identifier
    else
      flash[:warning] = t('.error_saving_deploy')
      render action: :new
    end
  end

  def delete
    flash[:info]=t('.deleted')
    @deploy.destroy
    redirect_to action: :index
  end


  private


  def load_from_params
    date = Date.parse(params[:deploy][:date])
    start_time = Time.parse(params[:deploy][:start_time])
    end_time = Time.parse(params[:deploy][:estimated_end_time])
    deploy_name = date.strftime('%Y%m%d') + start_time.strftime('%H%M')

    deploy_params = params[:deploy].permit(:affected_projects, :release_notes, {:issue_ids => []}, :approved, :date, :start_time, :estimated_end_time, :authorization)
    deploy_params[:deploy_name] = deploy_name
    deploy_params[:date] = date
    deploy_params[:start_time] = start_time
    deploy_params[:estimated_end_time] = end_time
    deploy_params[:project] = params[:project_id]
    deploy_params[:version_id] = params[:version]

    deploy_params
  end

  def load_deploy
    @deploy = Deploy.find_by_id(params[:id])
    @project_issues = @project.issues
  end

  def load_author
    unless @deploy.user_id.blank?
      @user = User.find @deploy.user_id
    end
  end

  def load_version
    unless @deploy.version_id.blank?
      @version = Version.find @deploy.version_id
    end
  end

  def load_project
    @project = Project.find_by(identifier: params[:project_id])
  end

  def set_recipients
    @recipients = @project.customers_deploys_notifications_emails
    if params[:client].present?
      if params[:client]=='false'
        @recipients = ''
      end
    end
  end


end
