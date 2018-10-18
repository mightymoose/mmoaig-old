{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.AuthorizationEndpoint (authorizationEndpoint) where

import Servant (Handler)
import Jose.Jwk (generateRsaKeyPair, KeyUse(Sig))
import Jose.Jwa (Alg(Signed), JwsAlg(RS256), JweAlg(RSA_OAEP), Enc(A128GCM))
import Jose.Jwt (Jwt(Jwt), KeyId(KeyId), Payload(Claims))
import Jose.Jwe (jwkEncode)
import Control.Monad.IO.Class (liftIO)
import Data.ByteString.Char8 (unpack)
import Data.Text (pack)

authorizationEndpoint :: String -> Handler String
authorizationEndpoint secretKey = do
  (kPub, _) <- liftIO $ generateRsaKeyPair 256 (KeyId (pack secretKey)) Sig (Just (Signed RS256))
  Right (Jwt jwt) <- liftIO $ jwkEncode RSA_OAEP A128GCM kPub (Claims "secret claims")
  return $ unpack jwt
