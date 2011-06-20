require 'digest/sha1'

class TokenGenerator

  def self.generate(length = nil)
    digest = Digest::SHA1.hexdigest(Time.now.to_s + rand(89273489).to_s)

    if length && length < digest.size
      digest[1..length]
    else
      digest
    end
  end

end
