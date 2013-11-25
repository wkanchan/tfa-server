class User < ActiveRecord::Base

  belongs_to :corporate

  def self.sign_in(corporate_id, otp)
    begin
      corporate = Corporate.find(corporate_id)
    rescue
      return { result: 0, message: "Invalid corporate ID" }
    end
    corporate_key = corporate.key
    unescaped_otp = URI.decode(otp).gsub "\\n","\n"
    begin
      plain = AES.decrypt(unescaped_otp, corporate_key)
    rescue Exception => e
      return { result: 0, message: "Invalid key or OTP" }
    end
    splitted = plain.split(",")
    user_id = splitted[0]
    nonce = splitted[1].to_i
    passcode = splitted[2]

    stored_user = User.find(user_id)
    # Check whether received decrypted user_id is consistent with received corporate_id
    if stored_user.corporate.id == corporate.id
      # Check whether received passcode is valid
      if (stored_user.passcode == passcode)
        # Generate a new passcode
        new_passcode = Digest::SHA1.hexdigest(passcode+rand(2**128).to_s(16))
        stored_user.passcode = new_passcode
        stored_user.save

        new_nonce = nonce+1
        new_plain = user_id+","+new_nonce.to_s+","+new_passcode
        new_otp = AES.encrypt(new_plain, corporate_key)

        return { result: 1, otp: new_otp }
      else
        return { result: 0, message: 'Invalid passcode' }
      end
    else
      return { result: 0, message: 'Invalid corporate ID or user ID' }
    end

  end

end
