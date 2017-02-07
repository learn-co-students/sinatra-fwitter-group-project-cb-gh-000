class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end

    create_table :tweets do |t|
      t.string :content
      t.belongs_to :user, index: true
    end
  end
end
