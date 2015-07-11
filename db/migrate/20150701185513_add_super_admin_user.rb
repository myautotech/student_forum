class AddSuperAdminUser < ActiveRecord::Migration
  def change
    role = Role.find_by(name: 'SuperAdmin')
    super_user = User.new(email: 'super@studentforum.com'\
      , password: 'password!2#', first_name: 'Super'\
      , last_name: 'Admin', role_id: role.id)
    super_user.save(validate: false)
  end
end
