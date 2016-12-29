class IndexController < ApplicationController
  # GET /Index
  def index
    @users = User.all
  end

  def index2
    @users = User.all
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :age)
  end
end