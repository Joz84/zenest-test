class AdminEmployee::RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]
  before_action :set_rooms, only: [:create, :edit, :update, :destroy]
  after_action :redirect_to_index, only: [:create, :edit, :update, :destroy ]
  def index
    @rooms = policy_scope([:admin_employee, Room])
    authorize([:admin_employee, @rooms])
    @room = Room.new
    render layout: "dashboard"
  end

  def create
    @room = Room.new(room_params)
    @room.company = current_user.actable.company
    authorize ([:admin_employee, @room])
    @room.save
  end

  def edit
    authorize ([:admin_employee, @room])
  end

  def update
    authorize ([:admin_employee, @room])
    @room.update(room_params)
  end

  def destroy
    authorize ([:admin_employee, @room])
    @room.destroy
  end

  private

  def set_rooms
    @rooms = current_user.actable.company.rooms
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :capacity)
  end

  def redirect_to_index
    respond_to do |format|
      format.html {redirect_to admin_employee_rooms_path}
      format.js
    end
  end
end
