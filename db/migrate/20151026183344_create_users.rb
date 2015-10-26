class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firs_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :age
      t.string :gender
      t.string :home
      t.string :work
      t.string :avatar_file_name
      t.string :avatar_file_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps null: false
    end
  end
end
