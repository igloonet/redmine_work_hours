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
end
