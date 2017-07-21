class WorkHoursSettingsController < ApplicationController
  unloadable
  layout 'base'
  menu_item :work_hours

  before_filter :find_project, :authorize, :find_user

  def update
    @setting = WorkHoursProjectSetting.find_or_create(@project)

    # @setting.safe_attributes = params[:setting]
    @setting.text_during_work_hours = params[:setting][:text_during_work_hours]
    @setting.text_not_during_work_hours = params[:setting][:text_not_during_work_hours]
    @setting.updated_by = @user_id

    @setting.save!
    flash[:notice] = l(:notice_successful_update)
    redirect_to :controller => 'projects', :action => "settings", :id => @project, :tab => 'work_hours'
  end

  private
  def find_project
    # @project variable must be set before calling the authorize filter
    @project = Project.find(params[:id])
  end

  def find_user
    @user = User.current
  end

end
