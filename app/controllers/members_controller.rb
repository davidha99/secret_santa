class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_path, notice: "Family Member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to members_path, notice: "Member was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    redirect_to members_path, notice: "Member was successfully destroyed."
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name)
  end
end
