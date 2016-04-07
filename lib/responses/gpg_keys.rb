module GitHub
  module Resources
    module Responses
      GPG_KEY ||= {
        "id" => 3,
        "primary_key_id" => nil,
        "key_id" => "3262EFF25BA0D270",
        "public_key" => "xsBNBFayYZ...",
        "emails" => [
          {
            "email" => "mastahyeti@users.noreply.github.com",
            "verified" => true
          }
        ],
        "subkeys" => [
          {
            "id" => 4,
            "primary_key_id" => 3,
            "key_id" => "4A595D4C72EE49C7",
            "public_key" => "zsBNBFayYZ...",
            "emails" => [],
            "subkeys" => [],
            "can_sign" => false,
            "can_encrypt_comms" => true,
            "can_encrypt_storage" => true,
            "can_certify" => false,
            "created_at" => "2016-03-24T11:31:04-06:00",
            "expires_at" => nil
          }
        ],
        "can_sign" => true,
        "can_encrypt_comms" => false,
        "can_encrypt_storage" => false,
        "can_certify" => true,
        "created_at" => "2016-03-24T11:31:04-06:00",
        "expires_at" => nil}
    end
  end
end
