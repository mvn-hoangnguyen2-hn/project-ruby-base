class AddAgeAndPhoneToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :phone, :string
  end
end
