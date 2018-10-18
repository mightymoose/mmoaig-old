module MmoaigAPISpecs.ConfigurationSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it, shouldBe)
    
import Database.PostgreSQL.Simple (connectHost, connectPort, connectUser, connectPassword, connectDatabase)
    
import MmoaigAPI.Environment (createEnvironment)
import MmoaigAPI.Configuration (createConnectInfo)
    
spec :: Spec
spec = parallel $
  describe "MmoaigAPI.Configuration" $
    describe "createConnectInfo" $ do
      let rawEnvironment = [ ("POSTGRES_HOST", "host")
                           , ("POSTGRES_PORT", "123")
                           , ("POSTGRES_USER", "user")
                           , ("POSTGRES_PASSWORD", "password")
                           , ("POSTGRES_DB", "database")
                           , ("SECRET_KEY", "secret")
                           ]
      let environment = createEnvironment rawEnvironment
      let connectInfo = createConnectInfo <$> environment
      it "sets connectHost" $
        connectHost <$> connectInfo `shouldBe` Just "host"
      it "sets connectPort" $
        connectPort <$> connectInfo `shouldBe` Just 123
      it "sets connectUser" $
        connectUser <$> connectInfo `shouldBe` Just "user"
      it "sets connectPassword" $
        connectPassword <$> connectInfo `shouldBe` Just "password"
      it "sets connectDatabase" $
        connectDatabase <$> connectInfo `shouldBe` Just "database"
