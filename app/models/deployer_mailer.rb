class DeployerMailer < Mailer

  default from: "from@test.com"

  layout "mailer"


  def send_start(deploy, project)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name}"
    mail to: project.customers_deploys_notifications_emails, cc: project.deploys_notifications_emails, subject: mail_subject
  end


  def send_successful_end(deploy, project)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name} - Correcto"
    mail to: project.customers_deploys_notifications_emails, cc: project.deploys_notifications_emails, subject: mail_subject
  end

  def send_rollback(deploy, project)
    @deploy = deploy
    mail_subject = "[deploys] {#{project.abbreviation}} Notificación de despliegue #{deploy.deploy_name} - Rollback"
    mail to: project.customers_deploys_notifications_emails, cc: project.deploys_notifications_emails, subject: mail_subject
  end

end
