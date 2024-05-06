class MembersController < ApplicationController
  before_action :set_family
  before_action :set_member, only: %i[edit update destroy]

  def new
    @member = @family.members.build
  end

  def create
    @member = @family.members.build(member_params)

    if @member.save
      respond_to do |format|
        format.html { redirect_to family_path(@family), notice: 'Member was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Member was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @member.update(member_params)
      respond_to do |format|
        format.html { redirect_to family_path(@family), notice: 'Member was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Member was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to family_path(@family), notice: 'Member was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Member was successfully destroyed.' }
    end
  end

  private

  def set_member
    @member = @family.members.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name).merge(user: current_user)
  end

  def set_family
    @family = Family.find(params[:family_id])
  end
end
