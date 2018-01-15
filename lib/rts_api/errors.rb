module RtsApi
  module Errors
    DESCRIPTIONS = { 
      100 => 'No data packet was decrypted (possible encryption error)',
      101 => 'No <Payment> nodes specified',
      102 => 'Gift request received, but user does not have rights to sell gifts cards'
    }
  end
end

