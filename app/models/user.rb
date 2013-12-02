class User < ActiveRecord::Base

  belongs_to :corporate

  def self.sign_in(received_user_id, corporate_id, otp)

    # Check corporate ID
    begin
      corporate = Corporate.find(corporate_id)
    rescue
      return { result: 0, message: "Corporate ID is incorrect." }
    end

    # Decrypt OTP
    unescaped_otp = URI.decode(otp).gsub "\\n","\n"
    begin
      plain = AES.decrypt(unescaped_otp, corporate.key)
    rescue Exception => e
      return { result: 0, message: "Could not decrypt OTP because of OTP or passcode is incorrect." }
    end
    splitted = plain.split(",")
    decrypted_user_id = splitted[0].to_i
    nonce = splitted[1].to_i
    passcode = splitted[2]

    # Check received user ID must be the same as in the OTP
    begin
      received_user = User.find(received_user_id)
      puts "*** received_user.id = "+received_user.id.to_s
      puts "*** decrypted_user_id = "+decrypted_user_id.to_s
      if received_user.id != decrypted_user_id
        return { result: 0, message: "Incorrect OTP for this user."} 
      end
    rescue Exception => e
      puts $!
      return { result: 0, message: "Error in user in OTP."}
    end

    target_user = User.find(decrypted_user_id)
    # Check whether received decrypted user_id is consistent with received corporate_id
    if target_user.corporate.id == corporate.id
      # Check whether received passcode is valid
      if (target_user.passcode == passcode)
        # Generate a new passcode
        new_passcode = Digest::SHA1.hexdigest(passcode+rand(2**128).to_s(16))
        target_user.passcode = new_passcode
        target_user.save

        new_nonce = nonce+1
        new_plain = decrypted_user_id.to_s+","+new_nonce.to_s+","+new_passcode
        new_otp = AES.encrypt(new_plain, corporate.key)

        return { result: 1, otp: new_otp }
      else
        return { result: 0, message: 'Incorrect passcode for this user and corporate.' }
      end
    else
      return { result: 0, message: 'Decrypted corporate ID and user ID are inconsistent.' }
    end

  end

end
