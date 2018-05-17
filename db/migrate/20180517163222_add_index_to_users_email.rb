class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    #ted-may 17 2018  to create email index in the database
    #to slove the famouse dupicate email problem in the database
     add_index :users, :email, unique: true
  end
end
