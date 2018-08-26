module MmoaigAPISpecs.EnvironmentSpec (spec) where

import Test.Hspec (Spec, context, shouldBe, parallel, describe, it)

import MmoaigAPI.Environment (createEnvironment, postgresHost, postgresPort, postgresUser, postgresPassword, postgresDatabase)

spec :: Spec
spec = parallel $
  describe "MmoaigAPI.Environment" $
    describe "createEnvironment" $ do
      context "with no host" $
        it "returns an error" $ do
          let rawEnvironment = []
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with no port" $
        it "returns an error" $ do
          let rawEnvironment = [("POSTGRES_HOST", "host")]
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with an invalid port" $ do
        let rawEnvironment = [("POSTGRES_HOST", "host"), ("POSTGRES_PORT", "invalidPort"), ("POSTGRES_USER", "user"), ("POSTGRES_PASSWORD", "password"), ("POSTGRES_DB", "database")]
        it "returns an error" $
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with no user" $
        it "returns an error" $ do
          let rawEnvironment = [("POSTGRES_HOST", "host"), ("POSTGRES_PORT", "port")]
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with no password" $
        it "returns an error" $ do
          let rawEnvironment = [("POSTGRES_HOST", "host"), ("POSTGRES_PORT", "port"), ("POSTGRES_USER", "user")]
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with no database" $
        it "returns an error" $ do
          let rawEnvironment = [("POSTGRES_HOST", "host"), ("POSTGRES_PORT", "123"), ("POSTGRES_USER", "user"), ("POSTGRES_PASSWORD", "password")]
          createEnvironment rawEnvironment `shouldBe` Nothing
      context "with all of the required fields" $ do
        let rawEnvironment = [("POSTGRES_HOST", "host"), ("POSTGRES_PORT", "123"), ("POSTGRES_USER", "user"), ("POSTGRES_PASSWORD", "password"), ("POSTGRES_DB", "database")]
        let result = createEnvironment rawEnvironment
        it "returns the correct host" $
          postgresHost <$> result `shouldBe` lookup "POSTGRES_HOST" rawEnvironment
        it "returns the correct port" $
          postgresPort <$> result `shouldBe` read <$> lookup "POSTGRES_PORT" rawEnvironment
        it "returns the correct user" $
          postgresUser <$> result `shouldBe` lookup "POSTGRES_USER" rawEnvironment
        it "returns the correct password" $
          postgresPassword <$> result `shouldBe` lookup "POSTGRES_PASSWORD" rawEnvironment
        it "returns the correct database" $
          postgresDatabase <$> result `shouldBe` lookup "POSTGRES_DB" rawEnvironment
    
