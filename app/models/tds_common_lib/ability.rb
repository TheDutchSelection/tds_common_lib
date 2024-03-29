module TdsCommonLib
  class Ability < ApplicationRecord
    validates :user_id, :user_type, :permission, presence: true
    validates_uniqueness_of :permission, scope: [:user_id, :user_type]

    def self.user_has_permission?(user, permission)
      user_abilities = where(user_id: user.id, user_type: user.class.name)

      if permission.is_a?(Array)
        has_permission = false
        permission.each do |permis|
          has_permission = user_abilities.find { |ua| ua.permission.to_s == permis.to_s }.present?
          break if has_permission
        end

        has_permission
      else
        user_abilities.find { |ua| ua.permission.to_s == permission.to_s }.present?
      end
    end

    def self.create_abilities_from_role(user)
      user_roles = user.role

      if user_roles.is_a?(Array)
        user_roles.each do |user_role|
          role = Role.new(user.class.name, user_role)

          if role.name != :admin
            role.permissions.each do |permission|
              create_or_find_by(user_id: user.id, user_type: user.class.name, permission: permission)
            end
          end
        end
      else
        role = Role.new(user.class.name, user_roles)

        if role.name != :admin
          role.permissions.each do |permission|
            create_or_find_by(user_id: user.id, user_type: user.class.name, permission: permission)
          end
        end
      end
    end

    def self.reset_abilities_from_role(user)
      Ability.where(user_id: user.id, user_type: user.class.name).destroy_all
      create_abilities_from_role(user)
    end
  end
end
