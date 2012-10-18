# encoding: UTF-8
require 'redmine'
require 'work_hours_projects_helper_patch'
require 'work_hours_issue_hook'

Redmine::Plugin.register :redmine_work_hours do
  name 'Redmine Work Hours plugin'
  author 'Marek Hulán'
  description 'This is a work hours plugin for redmine'
  version '0.0.1'

  project_module :work_hours do
    permission :work_hours_setting, {:work_hours_settings => [:show, :update]}, :require => :member
  end


  default_settings = {}
  I18n.t('date.day_names', :locale => :en).map(&:last).each do |day_name|
    default_settings[day_name.downcase+'_hours_from'] = '8:00'
    default_settings[day_name.downcase+'_hours_to'] = '17:00'
  end
  
  settings :default => default_settings, :partial => 'settings/work_hours_settings'
end
