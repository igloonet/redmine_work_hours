class CreateWorkHoursProjectSetting < ActiveRecord::Migration
  def self.up
    create_table :work_hours_project_settings do |t|

      t.column :project_id, :integer

      t.column :created_at, :timestamp

      t.column :updated_at, :timestamp

      t.column :updated_by, :integer

      t.column :text_during_work_hours, :text

      t.column :text_not_during_work_hours, :text

    end
  end

  def self.down
    drop_table :work_hours_project_settings
  end
end