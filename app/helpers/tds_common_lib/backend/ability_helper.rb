module TdsCommonLib
  module Backend
    module AbilityHelper

      def has_permission?(user, permission)
        Ability.user_has_permission?(user, permission) ||
          (user.respond_to?(:role) && user.role.to_sym == :admin)
      end
    end
  end
end
