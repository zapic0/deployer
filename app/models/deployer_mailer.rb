class DeployerMailer < Mailer

  default from: "from@test.com"

  layout "mailer"


  def send_start(deploy, project, recipients)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name}"
    mail to: recipients, bcc: project.deploys_notifications_emails, subject: mail_subject
  end


  def send_successful_end(deploy, project, recipients)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name}"
    mail to: recipients, bcc: project.deploys_notifications_emails, subject: mail_subject
  end

  def send_rollback(deploy, project, recipients)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name}"
    mail to: recipients, bcc: project.deploys_notifications_emails, subject: mail_subject
  end

  private


end
