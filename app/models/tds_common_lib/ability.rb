module TdsCommonLib
  class Ability < ApplicationRecord
    validates :user_id, :user_type, :permission, presence: true
    validates_uniqueness_of :permission, scope: [:user_id, :user_type]

    def self.user_has_permission?(user, permission)
      find_by(user_id: user.id, user_type: user.class.name, permission: permission).present?
    end

    def self.create_abilities_from_role(user)
      role = Role.new(user.class.name, user.role)

      if role.name != :admin
        role.permissions.each do |permission|
          create_or_find_by(user_id: user.id, user_type: user.class.name, permission: permission)
        end
      end
    end

    def self.reset_abilities_from_role(user)
      Ability.where(user_id: user.id).destroy_all
      create_abilities_from_role(user)
    end
  end
end
