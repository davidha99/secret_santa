class FamiliesController < ApplicationController
  before_action :set_family, only: %i[show edit update destroy]

  def index
    @families = Family.where(user: current_user)
  end

  def show
    @members = @family.members
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)

    if @family.save
      respond_to do |format|
        format.html { redirect_to families_path, notice: 'Fam was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Fam was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @family.update(family_params)
      respond_to do |format|
        format.html { redirect_to families_path, notice: 'Fam was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Fam was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @families = Family.where(user: current_user)
    @family.destroy

    respond_to do |format|
      format.html { redirect_to families_path, notice: 'Fam was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Fam was successfully destroyed.' }
    end
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name).merge(user: current_user)
  end
end
