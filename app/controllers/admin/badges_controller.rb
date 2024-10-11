class Admin::BadgesController < Admin::BaseController
  before_action :set_badge, only: %i[edit update destroy]

  def index
    @badges = Badge.order(created_at: :desc)
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def delete; end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @badge.badge_to_users.delete_all
    @badge.destroy
    redirect_to admin_badges_path, notice: t('.success')
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :image_url, :description, :condition)
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
