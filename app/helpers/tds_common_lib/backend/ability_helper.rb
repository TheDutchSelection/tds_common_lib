module TdsCommonLib
  module Backend
    module AbilityHelper

      def has_permission?(user, permission)
        has_permission = false

        if Ability.user_has_permission?(user, permission)
          has_permission = true
        elsif user.respond_to?(:role)
          role = user.role
          if role.is_a?(Array)
            role.each do |rol|
              has_permission = rol.to_sym == :admin
              break if has_permission
            end
          else
            has_permission = user.role.to_sym == :admin
          end
        end

        has_permission
      end
    end
  end
end
