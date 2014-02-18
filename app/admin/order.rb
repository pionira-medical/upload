ActiveAdmin.register Order do
  menu priority: 2
  index do
    column :order_number
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Content" do
      f.input :order_number
      f.input :security_key
      f.input :description
    end
    f.inputs "Contact", for: [:user, f.object.build_user] do |uf|
        uf.input :gender
        uf.input :academic_title
        uf.input :first_name
        uf.input :last_name
        uf.input :email
    end
    f.inputs do
      f.has_many :addresses, :allow_destroy => true, :new_record => true do |af|
        af.input :type
        af.input :academic_title
        af.input :first_name
        af.input :last_name
        af.input :gender
        af.input :hospital
        af.input :department
        af.input :street_1
        af.input :street_2
        af.input :zip
        af.input :city
        af.input :country, :as => :string
        af.input :email
        af.input :phone
        af.input :reference
      end
    end
    f.actions
  end
end
