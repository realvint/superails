class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @pagy, @products = pagy Product.all.order :name

    respond_to do |format|
      format.html
      format.json {
        render json: { entries: render_to_string(partial: 'products', formats: [:html]),
                       pagination: view_context.pagy_bootstrap_nav(@pagy) }
      }
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export
    @products = Product.all
    render xlsx: 'create', template: 'products/export'
  end

  def import
    file = params[:file].tempfile
    spreadsheet = Roo::Excelx.new(file).to_a
    spreadsheet.each do |item_array|
      #id = item_array[0]
      name = item_array[0]
      price = item_array[2]
      in_stock = item_array[1]

      product = Product.find_or_create_by(name: name)
      product.update(name: name, price: price, in_stock: in_stock)
    end
    redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :in_stock)
  end
end
