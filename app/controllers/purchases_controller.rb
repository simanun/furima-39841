class PurchasesController < ApplicationController
  def index
    @purchase_address = Purchase_address.all
  end

  def create
  end
end
