# frozen_string_literal: true

module API
  class UsersController < ApplicationController
    def index
      render json: User.all
    end

    def show
      render json: User.find(params[:id])
    end
  end
end
