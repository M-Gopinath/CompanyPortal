class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def facebook
    social_response
    redirect_to dashboard_edit_profile_path
  end

  def twitter
    social_response
    redirect_to dashboard_edit_profile_path
  end

  def google_oauth2
    social_response
    redirect_to dashboard_edit_profile_path
  end

  def linkedin
    social_response
    redirect_to dashboard_edit_profile_path
  end

  def social_response
    data = request.env['omniauth.auth']
    if current_client.present?
      current_client.social_nework(data)
    end
  end


end
