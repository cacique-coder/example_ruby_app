class UsersController < AuthenticationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,
                        :edit_password, :update_password, :change_status]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page]).decorate
  end

  def show
    @user = @user.decorate
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'El usuario ha sido creado exitosamente'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'El usuario ha sido actualizado exitosamente'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def edit_password
  end

  def update_password
    if @user.update(user_params_password)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def change_status
    @user.change_status!
    redirect_to user_path(@user)
  end
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:saint_id,:name,:login,
        :type, :status, :email)
    end

    def user_params_password
      params.require(:user).permit(:password,:password_confirmation)
    end
end
