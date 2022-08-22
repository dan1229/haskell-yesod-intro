module Settings where

import Data.Aeson

newtype AppSettings = AppSettings { jwt :: String }


getsAppSettings :: HasAppSettings m => (AppSettings -> a) -> m a
getsAppSettings f = f <$> getAppSettings 

class Monad m => HasAppSettings m where
    getAppSettings :: m AppSettings

class Monad m => HasJwt m where
    getJwt :: m String

instance FromJSON AppSettings where
    parseJSON = withObject "AppSettings" $ \o -> AppSettings <$> o .: "jwt"