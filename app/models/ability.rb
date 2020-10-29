# frozen_string_literal: true

# :nodoc:
class Ability
  include CanCan::Ability

  def initialize(user, token = nil)
    return unless user || token

    if token
      token_payload = if token
                        JWT.decode(
                          token,
                          Settings.jwt.secret,
                          Settings.jwt.algorithm
                        )[0]
                      else
                        {}
                      end

      can :read, Organization, allowlisted_jwts: { jti: token_payload['jti'] }

      can %i[create read update], [Stream, Upload, Batch], organization: { allowlisted_jwts: { jti: token_payload['jti'] } }

      return
    end

    can :manage, :all if user.has_role?(:admin)
    can :read, Organization if user

    owned_orgs = Organization.with_role(:owner, user).pluck(:id)
    can :manage, Organization, id: owned_orgs
    can :manage, [Stream, Upload, Batch], organization: { id: owned_orgs }

    member_orgs = Organization.with_role(:member, user).pluck(:id)
    can :manage, [Stream, Upload, Batch], organization: { id: member_orgs }
  end
end
