module PointsExpirations
  class List
    include Interactor

    def call
      context.points_expirations = context.user.points_expirations
    end
  end
end
