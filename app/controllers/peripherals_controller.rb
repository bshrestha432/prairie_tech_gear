class PeripheralsController < ApplicationController
  def index
    @peripherals = Peripheral.all
  end

  def show
    @peripheral = Peripheral.find(params[:id])
  end
end