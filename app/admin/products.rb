# app/admin/product.rb
ActiveAdmin.register Product do
  # Permit parameters
  permit_params :name, :description, :price, :stock_quantity, :category_id, images: []

  # Pagination configuration
  config.per_page = 3  # Set default items per page
  config.paginate = true  # Explicitly enable pagination

  # Add per page selection dropdown
  config.per_page = [3, 6, 12, 24]

  # Index view with pagination
  index do
    selectable_column
    column :id
    column :name
    column :price do |product|
      number_to_currency(product.price)
    end
    column :stock_quantity
    column :category
    column :images do |product|
      if product.images.attached?
        image_tag(product.images.first.variant(resize: "50x50"))
      else
        "No image"
      end
    end
    actions
  end

  # Form configuration
  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :images, as: :file,
                      input_html: { multiple: true },
                      hint: f.object.images.attached? ?
                            "Current images: #{f.object.images.count}" :
                            "Upload product images"
    end
    f.actions
  end

  # Show page configuration
  show do
    attributes_table do
      row :name
      row :description
      row :price do |product|
        number_to_currency(product.price)
      end
      row :stock_quantity
      row :category
      row :images do
        if product.images.attached?
          div class: 'product-images' do
            product.images.each do |img|
              div class: 'image-thumbnail' do
                link_to image_tag(img.variant(resize: "200x200")), img, target: '_blank'
              end
            end
          end
        else
          "No images attached"
        end
      end
    end
    active_admin_comments
  end

  # Controller customization
  controller do
    def scoped_collection
      super.includes(:category)  # Prevent N+1 queries
    end
  end

  # Filter configuration
  filter :name
  filter :category
  filter :price
  filter :stock_quantity
  filter :created_at
end