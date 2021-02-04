module TdsCommonLib
  class Role

    attr_reader :name, :user_type

    def initialize(user_type, name)
      @name = name.to_sym
      @user_type = user_type
    end

    def self.roles(user_type)
      TdsCommonLib.configuration.user_roles[user_type]
    end

    def permissions
      Role.roles(@user_type)[@name]
    end
  end
end
