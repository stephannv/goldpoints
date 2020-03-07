module Users
  class Create
    include Interactor

    def call
      context.user = User.create!(context.user_attributes)
    end
  end
end
