class CustomersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_correct_user, only: [:edit, :update]


end
