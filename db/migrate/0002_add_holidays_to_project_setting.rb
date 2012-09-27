class AddHolidaysToProjectSetting < ActiveRecord::Migration
  def self.up
    add_column :work_hours_project_settings, :holidays, :text
  end

  def self.down
    remove_column :work_hours_project_settings, :holidays
  end
end
