class AddRoles < ActiveRecord::Migration
  def change
    roles = %w(SuperAdmin Admin GroupAdmin Member)
    roles.each { |r| Role.create(name: r) }
  end
end
