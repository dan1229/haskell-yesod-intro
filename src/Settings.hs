module Settings where

import Data.Aeson
import Data.Aeson.Types
import Control.Monad

newtype AppSettings = AppSettings { jwt :: String }


getsAppSettings :: HasAppSettings m => (AppSettings -> a) -> m a
getsAppSettings f = f <$> getAppSettings 

class Monad m => HasAppSettings m where
    getAppSettings :: m AppSettings

class Monad m => HasJwt m where
    getJwt :: m String


instance FromJSON AppSettings where
    parseJSON (Object o) = do
        settings <- o .: "appSettings"
        case settings of
            "jwt" -> return settings
            _    -> mzero
    parseJSON v = typeMismatch "jwt" v