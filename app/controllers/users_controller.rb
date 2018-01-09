class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {:status => 200}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /login
  def login
    username = params[:name]
    input_hashed = params[:hashed]
    @user = User.where(name: username)
    if @user.exists?
      login_info = @user.all.to_a.map(&:serializable_hash)[0]
      # クライアント側の実装が間に合っていないため一旦ハッシュ化による検証は保留
      hashed = Digest::SHA512.hexdigest(login_info["name"] + ":::" + login_info["password"])
      if hashed == input_hashed
        login_info["token"] = SecureRandom.hex(32)
        render json: login_info
        return
      end
    end
    dummy = User.new(id: 0)
    render json: dummy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
