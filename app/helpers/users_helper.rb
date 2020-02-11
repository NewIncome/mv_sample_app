module UsersHelper
  # Gravatar URLS are based on MD5 Hash of the users email.
  # In Ruby this Hash algorithm is implemented using the
  # 'hexdigest' method which is part of the Digest library.

  def gravatar_for(user)# (1)this can also be done:   , size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # (2)and this:   #{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size:100)
  end
end
