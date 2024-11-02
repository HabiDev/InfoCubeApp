class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [ :index, :new, :create ]
  
  def index
    # authorize User
    @q = User.includes(:profile).ransack(params[:q])
    @q.sorts = ['full_name asc'] if @q.sorts.empty?
    @count_users = @q.result.count
    @pagy, @users = pagy(@q.result(disinct: true), items: 20) 
  end

  def new
    # authorize Users
    #@user = User.new(password: 'UserBlock', password_confirmation: 'UserBlock', locked_at: DateTime.now)
    @user = User.new
    @user.build_profile
  end

  def show
    # authorize @user
  end

  def edit
    # authorize @user
    @user.profile
  end

  def edit_password_reset
   
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
      # authorize @user   
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t('notice.record_create') }
        format.turbo_stream { flash.now[:success] = t('notice.record_create') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    # authorize @user    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: t('notice.record_edit') }
        format.turbo_stream { flash.now[:warning] = t('notice.record_edit') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def password_reset
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    respond_to do |format|
      unless @user.reset_password(password, password_confirmation)
        format.html { render :edit_password_reset, status: :unprocessable_entity }
      else
        if @user.update_without_password(user_params)
          format.html { redirect_to users_path, notice: t('notice.record_edit') }
          format.turbo_stream { flash.now[:warning] = t('notice.record_edit') }
        else
          format.html { render :edit_password_reset, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    # authorize @user
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to users_path, notice: t('notice.record_destroy') }
        format.turbo_stream { flash.now[:danger] = t('notice.record_destroy') }
      end
      # flash[:success] = "Пользователь удачно удален."
      # redirect_to users_path, status: :see_other
    else
      flash.now[:error] = t('notice.record_destroy_errors')
    end
  end

  def lock
    respond_to do |format|
      if @user.update(locked_at: DateTime.now)
        format.html { redirect_to users_path, notice: t('notice.record_edit') }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@user) }
        format.turbo_stream { flash.now[:warning] = t('notice.record_edit') }
      else
        format.html { render :lock, status: :unprocessable_entity }
      end
    end
  end

  def unlock
    respond_to do |format|
      if @user.update(locked_at: "")
        format.html { redirect_to users_path, notice: t('notice.record_edit') }
        format.turbo_stream { flash.now[:warning] = t('notice.record_edit') }
      else
        format.html { render :lock, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :type_role, :password, :password_confirmation, 
                                 profile_attributes: [:full_name, :mobile])
  end
end
