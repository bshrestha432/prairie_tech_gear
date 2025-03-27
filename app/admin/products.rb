# app/admin/product.rb
ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, images: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :images do
        div do
          product.images.each do |img|
            div do
              image_tag url_for(img), width: "200"
            end
          end
        end
      end
    end
    active_admin_comments
  end
end