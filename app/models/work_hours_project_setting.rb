class WorkHoursProjectSetting < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :project_id

  def self.find_or_create(project)
    setting = WorkHoursProjectSetting.find(:first, :conditions => ['project_id = ?', project.id])
    unless setting
      setting = WorkHoursProjectSetting.new
      setting.project_id = project.id
      setting.save!
    end
    setting
  end

  def self.settings_for_today
    setting = Setting.plugin_redmine_work_hours.with_indifferent_access
    day = I18n.t('date.day_names', :locale => :en)[Time.now.wday].downcase

    require 'ostruct'
    OpenStruct.new(from: Time.parse("#{setting[(day+'_hours_from').to_sym]}:00"), to: Time.parse("#{setting[(day+'_hours_to').to_sym]}:00"))
  end
end
