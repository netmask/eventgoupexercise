# frozen_string_literal: true

class GroupEventsController < ApplicationController
  before_action :set_group_event, only: %i[show edit update destroy]

  def index
    @group_events = current_user.group_events.all
  end

  def show; end

  def create
    @group_event = current_user.group_events.build(group_event_params)

    respond_to do |format|
      if @group_event.save
        format.json { render :show, status: :created, location: @group_event }
      else
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group_event.update(group_event_params)
        format.json { render :show, status: :ok, location: @group_event }
      else
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group_event.soft_destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def current_user
    @current_user = User.find params[:user_id]
  end

  def set_group_event
    @group_event = current_user.group_events.find(params[:id])
  end

  def group_event_params
    params.require(:group_event).permit(:status,
                                        :title,
                                        :description,
                                        :name,
                                        :location,
                                        :starts_at,
                                        :ends_at,
                                        :deleted_at)
  end
end
