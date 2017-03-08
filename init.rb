require_dependency 'deployer/hooks'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'deployer/issue_patch'
  require_dependency 'deployer/project_patch'
end


Redmine::Plugin.register :deployer do
  name 'Deployer plugin'

  author 'zapic0'
  description 'Redmine plugin that allows you to group issues into deploys and notify partners and customers'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://github.com/zapic0'


  permission :deploys, { :deploys => [:index, :show, :new, :create] }, :public => true

  menu :project_menu, :deploys, { :controller => 'deploys', :action => 'index' }, :caption => 'Deploys', :after=>:activity, :param=>:project_id

end
